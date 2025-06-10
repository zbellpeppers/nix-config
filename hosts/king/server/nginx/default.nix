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
        "CLOUDFLARE_EMAIL_FILE" = config.age.secrets.cf-email-nginx.path;
        "CLOUDFLARE_API_KEY_FILE" = config.age.secrets.cf-dns-nginx.path;
      };
    };
  };

  # Add nginx to acme group so it can access the environmental variable
  users.users.nginx.extraGroups = [ "acme" ];

  # Nginx config
  services.nginx = {
    enable = true;

    # Recommended security settings (optional but good practice)
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Actual Budget
    virtualHosts."actualbudget.bell-peppers.com" = {
      # Enable automatic certificate generation and renewal via ACME
      enableACME = true;
      # Automatically redirect HTTP traffic to HTTPS
      forceSSL = true;

      # Define where requests to the root path "/" should go
      locations."/" = {
        # The address of your running Actual Budget server
        proxyPass = "http://localhost:5006"; # Default port for Actual Budget

        # Add WebSocket support (often needed for modern web apps)
        proxyWebsockets = true; # Handles Upgrade and Connection headers automatically
      };

      # Optional: Add extra security headers (good practice)
      extraConfig = ''
        # Add HSTS header to force HTTPS in the browser for future visits
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
        # Prevent clickjacking
        add_header X-Frame-Options "SAMEORIGIN" always;
        # Prevent MIME-type sniffing
        add_header X-Content-Type-Options "nosniff" always;
        # Enable basic XSS protection
        add_header X-XSS-Protection "1; mode=block" always;
        # Control referrer policy
        add_header Referrer-Policy "strict-origin-when-cross-origin" always;
      '';
    };
  };
}
