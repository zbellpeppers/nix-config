{pkgs, ...}: {
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
          ports = ["0.0.0.0:5006:5006"];
          volumes = ["/home/zachary/Desktop/All/Documents/Accounting/actual-budget:/data"];
        };
        grocy = {
          image = "lscr.io/linuxserver/grocy:latest";
          pull = "newer";
          autoStart = true;
          ports = ["9283:80"];
          volumes = ["/var/lib/grocy:/config"];
          environment = {
            PUID = "1000";
            PGID = "1000";
            TZ = "Etc/UTC";
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
