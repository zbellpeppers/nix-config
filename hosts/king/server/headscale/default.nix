{
  config,
  pkgs,
  ...
}: let
  domain = "bell-peppers.com";
in {
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
      openFirewall = true;
    };

    headscale = {
      enable = true;
      address = "0.0.0.0";
      port = 8080;
      user = "headscale";
      group = "headscale";
      # tls_letsencrypt_hostname = "headscale.yourdomain.com";
      # tls_letsencrypt_challenge_type = "HTTP-01";
      # tls_letsencrypt_listen = ":http";
      settings = {
        log.level = "debug";
        log.format = "text";
        noise.private_key_path = "/var/lib/headscale/noise_private.key";
        server_url = "https://headscale.${domain}";
        dns = {
          magic_dns = true;
          base_domain = "${domain}";
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

    nginx.virtualHosts."headscale.${domain}" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:${toString config.services.headscale.port}";
        proxyWebsockets = true;
      };
    };
  };
  # environment.systemPackages = with pkgs; [
  #   headscale
  #   tailscale
  # ];
}
