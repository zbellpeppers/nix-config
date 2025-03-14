{
  config,
  pkgs,
  ...
}: {
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
  };

  networking.firewall = {
    checkReversePath = "loose";
    trustedInterfaces = ["tailscale0"];
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
    port = 443;
    settings = {
      # The URL clients will use to connect to your Headscale server
      # For local testing, you can use your local IP or hostname
      server_url = "https://headscale.bell-peppers.com:443";
      # Add TLS configuration using Let's Encrypt
      tls_letsencrypt_hostname = "headscale.bell-peppers.com";
      tls_letsencrypt_challenge_type = "HTTP-01";
      tls_letsencrypt_listen = ":80";

      # Define the IPv4 CIDR range for your tailnet
      prefixes = {
        v4 = "100.64.0.0/10"; # Default Tailscale range
        v6 = "fd7a:115c:a1e0::/48"; # Default Tailscale range
      };

      # DNS
      dns = {
        magic_dns = true;
        base_domain = "bpf.com";
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
