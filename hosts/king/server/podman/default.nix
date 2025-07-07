{
  pkgs,
  ...
}:
{
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
          ports = [ "0.0.0.0:5006:5006" ];
          volumes = [ "/home/zachary/Desktop/All/Documents/Accounting/actual-budget:/data" ];
          environment = {
            ACTUAL_HOSTNAME = "0.0.0.0";
            ACTUAL_PORT = "5006";
          };
        };
        homeassistant = {
          image = "ghcr.io/home-assistant/home-assistant:stable";
          pull = "newer";
          volumes = [
            "/home/zachary/Desktop/All/Self-hosting/home_assistant:/config"
            "/run/dbus:/run/dbus:ro"
          ];
          environment.TZ = "America/New_York";
          extraOptions = [
            "--network=host"
          ];
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
