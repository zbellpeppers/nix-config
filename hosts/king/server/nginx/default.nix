{ config, ... }:

{
  # secret for below
  age.secrets = {
    cloudflare-acme-credentials = {
      # The contents should be 'CLOUDFLARE_DNS_API_TOKEN=YOUR_TOKEN_HERE'
      file = ../../../../secrets/cloudflare-dns-token.age;
      path = "/run/secrets/cloudflare-acme-credentials";
    };
  };
  # ACME for SSL Certificates via Cloudflare
  security.acme = {
    acceptTerms = true;
    defaults.email = "zbellpeppers@pm.me";
  };

  security.acme.certs."bell-peppers.com" = {
    dnsProvider = "cloudflare";
    credentialFiles = {
      "CLOUDFLARE_DNS_API_TOKEN_FILE" = "/run/secrets/cloudflare-acme-credentials";
    };
    domain = "bell-peppers.com";
    extraDomainNames = [
      "actualbudget.bell-peppers.com"
      "traccar.bell-peppers.com"
      "haos.bell-peppers.com"
    ];
  };

  # NGINX Service Configuration
  services.nginx = {
    enable = true;

    # These options replicate best practices for security and performance.
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Define virtual hosts
    virtualHosts = {
      "haos.bell-peppers.com" = {
        # Automatically use the ACME cert and redirect HTTP to HTTPS.
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://localhost:8123";
        locations."/api/websocket" = {
          proxyPass = "http://localhost:8123/api/websocket";
          # This NixOS option adds the required headers for WebSockets
          proxyWebsockets = true;
        };
      };

      "headscale.bell-peppers.com" = {
        # Automatically use the ACME cert and redirect HTTP to HTTPS.
        forceSSL = true;
        enableACME = true;

        locations."/".proxyPass = "http://localhost:8080";

        # Additional headers for headscale
        extraConfig = ''
          add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        '';
      };

      "traccar.bell-peppers.com" = {
        # Use the existing ACME cert and force HTTPS
        forceSSL = true;
        enableACME = true;

        # Proxy main web traffic to Traccar's web interface
        locations."/".proxyPass = "http://localhost:8082";

        # Proxy the WebSocket connection for real-time updates
        locations."/api/socket" = {
          proxyPass = "http://localhost:8082/api/socket";
          proxyWebsockets = true; # Handles the necessary WebSocket headers
        };
      };
    };
  };
}
