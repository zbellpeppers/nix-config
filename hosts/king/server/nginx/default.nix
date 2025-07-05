{ pkgs, ... }:
{
  # secret for below
  age.secrets = {
    cloudflare-acme-credentials = {
      # The contents should be 'CLOUDFLARE_DNS_API_TOKEN=YOUR_TOKEN'
      file = ../../../../secrets/cloudflare-dns-token.age;
      path = "/run/secrets/cloudflare-acme-credentials";
      owner = "acme";
      group = "acme";
    };
  };
  # ACME for SSL Certificates via Cloudflare
  security.acme = {
    acceptTerms = true;
    defaults.email = "zbellpeppers@pm.me";
    certs."bell-peppers.com" = {
      dnsProvider = "cloudflare";
      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = "/run/secrets/cloudflare-acme-credentials";
      };
      # domain = "traccar.bell-peppers.com";
      # extraDomainNames = [
      # ];
    };
  };

  # NGINX Service Configuration
  users.users.nginx.extraGroups = [ "acme" ];
  services.nginx = {
    enable = true;

    # Per nixos wiki
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Define virtual hosts
    virtualHosts = {
      "headscale.bell-peppers.com" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:8080";
          proxyWebsockets = true;
        };
        # Additional headers for headscale
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
          proxy_set_header Host $server_name;
          proxy_redirect http:// https://;
          proxy_buffering off;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $http_x_forwarded_proto;
          add_header Strict-Transport-Security "max-age=15552000; includeSubDomains" always;
        '';
      };
      # "haos.bell-peppers.com" = {
      #   forceSSL = true;
      #   useACMEHost = "bell-peppers.com";
      #   locations."/" = {
      #     proxyPass = "http://127.0.0.1:8123";
      #     # proxyWebsockets = true; # Required for Home Assistant UI to function correctly
      #     extraConfig = ''
      #       proxy_set_header Host $host;
      #       proxy_set_header X-Real-IP $remote_addr;
      #     '';
      #   };
      # };
      # "traccar.bell-peppers.com" = {
      #   forceSSL = true;
      #   useACMEHost = "bell-peppers.com";
      #   locations."/".proxyPass = "http://localhost:8082";
      #   # Include a proxy for web socket
      #   locations."/api/socket" = {
      #     proxyPass = "http://localhost:8082/api/socket";
      #     proxyWebsockets = true;
      #   };
      #   extraConfig = '''';
      # };
    };
  };
}
