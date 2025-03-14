{
  config,
  pkgs,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = ["tailscale0"];
    allowedUDPPorts = [config.services.tailscale.port];
  };

  services.networkd-dispatcher = {
    enable = true;
    rules."50-tailscale" = {
      onState = ["routable"];
      script = ''
        ${pkgs.ethtool}/bin/ethtool -K eno1 rx-udp-gro-forwarding on rx-gro-list off
      '';
    };
  };
  services.headscale = {
    enable = true;
    # Listen on all interfaces
    address = "0.0.0.0";
    # Default port for Headscale
    port = 8080;
    settings = {
      # The URL clients will use to connect to your Headscale server
      # For local testing, you can use your local IP or hostname
      server_url = "http://localhost:8080";

      # Define the IPv4 CIDR range for your tailnet
      prefixes = {
        v4 = "100.64.0.0/10"; # Default Tailscale range
      };

      # DNS
      dns = {
        magic_dns = true;
        base_domain = "headscale.bpf";
      };

      # Database configuration (using SQLite by default)
      database = {
        type = "sqlite";
        sqlite = {
          path = "/var/lib/headscale/db.sqlite";
        };
      };

      # Basic logging configuration
      log = {
        level = "info";
        format = "text";
      };
    };
  };
}
