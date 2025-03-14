{
  pkgs,
  config,
  ...
}: {
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers = {
      backend = "podman";
      containers = {
        actual-budget = {
          image = "ghcr.io/actualbudget/actual:latest";
          pull = "newer";
          autoStart = true;
          ports = ["127.0.0.1:5006:5006"];
          volumes = ["/home/zachary/Desktop/All/Documents/Accounting/actual-budget:/data"];
          environment = {
            BUDGET_PASSWORD_FILE = config.age.secrets.actualbudget-password.path;
            API_KEY_FILE = config.age.secrets.actualbudget-apikey.path;
            HOSTNAME = "0.0.0.0";
            PORT = "5006";
          };
        };
      };
    };
  };

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev
  ];
}
