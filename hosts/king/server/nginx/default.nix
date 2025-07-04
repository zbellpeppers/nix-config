{ ... }:

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
      domain = "traccar.bell-peppers.com";
      extraDomainNames = [
        "actualbudget.bell-peppers.com"
      ];
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
      "haos.bell-peppers.com" = {
        forceSSL = true;
        useACMEHost = "bell-peppers.com";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8123";
          proxyWebsockets = true; # Required for Home Assistant UI to function correctly
          extraConfig = ''
            proxy_headers_hash_max_size 512;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
      };
      "headscale.bell-peppers.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://localhost:8080";
        # Additional headers for headscale
        extraConfig = ''
          proxy_headers_hash_max_size 512;
          add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        '';
      };
      "traccar.bell-peppers.com" = {
        forceSSL = true;
        useACMEHost = "bell-peppers.com";
        locations."/".proxyPass = "http://localhost:8082";
        # Include a proxy for web socket
        locations."/api/socket" = {
          proxyPass = "http://localhost:8082/api/socket";
          proxyWebsockets = true;
        };
        extraConfig = ''
          proxy_headers_hash_max_size 512;
        '';
      };
    };
  };
}
