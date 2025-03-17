{
  config,
  pkgs,
  ...
}: let
  domain = "bell-peppers.com";
in {
  # networking.localCommands = ''
  #   NETDEV=$(ip -o route get 8.8.8.8 | cut -f 5 -d " ")
  #   ${pkgs.ethtool}/bin/ethtool -K $NETDEV rx-udp-gro-forwarding on rx-gro-list off
  # '';
  networking.firewall = {
    allowedUDPPorts = [config.services.tailscale.port];
    checkReversePath = "loose";
    trustedInterfaces = ["tailscale0"];
  };
  services = {
    tailscale = {
      enable = true;
      port = 41641;
      useRoutingFeatures = "both";
      openFirewall = true;
    };

    headscale = {
      enable = true;
      address = "0.0.0.0";
      port = 8080;
      user = "headscale";
      group = "headscale";
      settings = {
        log.level = "debug";
        log.format = "text";
        noise.private_key_path = "/var/lib/headscale/noise_private.key";
        server_url = "https://headscale.${domain}";
        dns = {
          magic_dns = true;
          base_domain = "hs.${domain}";
          nameservers.global = ["1.1.1.1" "8.8.8.8"];
        };
        prefixes = {
          v4 = "100.64.0.0/10"; # Standard Tailscale IPv4 CIDR
          v6 = "fd7a:115c:a1e0::/48"; # Example IPv6 CIDR
          allocation = "sequential"; # Can be "random" or "sequential"
        };
        database = {
          type = "sqlite";
          sqlite = {
            path = "/var/lib/headscale/db.sqlite";
            write_ahead_log = true; # Recommended for performance
          };
        };
      };
    };
    nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts."headscale.${domain}" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://localhost:${toString config.services.headscale.port}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection "upgrade";
            proxy_set_header Host $host;
          '';
        };
      };
    };
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "zbellpeppers@pm.me";
  };
}
