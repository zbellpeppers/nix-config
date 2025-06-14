{ config, ... }:
{
  # Required for https cert generation via nginx
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "zbellpeppers@pm.me";
      dnsProvider = "cloudflare";
      # Use the agenix secret file for Cloudflare credentials
      credentialFiles = {
        # "CLOUDFLARE_EMAIL_FILE" = config.age.secrets.cf-email-nginx.path;
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = config.age.secrets.cf-dns-ddclient.path;
      };
    };
  };

  # Add nginx to acme group so it can access the environmental variable
  users.users.nginx.extraGroups = [ "acme" ];

  # Nginx config
  services.nginx = {
    enable = true;
    appendHttpConfig = ''
      map ''$http_upgrade ''$connection_upgrade {
        default upgrade;
        ""      close;
      }
    '';

    # Recommended security settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Actual Budget
    virtualHosts."actualbudget.bell-peppers.com" = {
      enableACME = true;
      forceSSL = true;
      acmeRoot = null; # Use DNS challenge

      locations."/" = {
        proxyPass = "http://localhost:5006";
        proxyWebsockets = true;
      };

      extraConfig = ''
        # Security headers
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-Content-Type-Options "nosniff" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header Referrer-Policy "strict-origin-when-cross-origin" always;
      '';
    };

    # Headscale
    virtualHosts."headscale.bell-peppers.com" = {
      enableACME = true;
      forceSSL = true;
      acmeRoot = null;

      locations."/" = {
        proxyPass = "http://0.0.0.0:8080";
        proxyWebsockets = true; # Keep this
        # Add these extra proxy settings
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection $connection_upgrade;
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_buffering off;
        '';
      };
    };
  };
}
