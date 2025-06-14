{ config, pkgs, ... }:

{
  services.caddy = {
    enable = true;

    # Build Caddy with the Cloudflare DNS plugin for ACME challenges
    # This is required to get SSL certificates when using Cloudflare's proxy.
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare"
      ];
      # On your first build, nix will fail with a hash mismatch.
      # Replace the hash below with the one provided in the error message.
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    # Configure Caddy to use the Cloudflare DNS challenge globally
    globalConfig = ''
      acme_dns cloudflare {env.CLOUDFLARE_DNS_API_TOKEN}
    '';

    # Securely provide the Cloudflare API token to Caddy via an environment file.
    # This reads the secret from your agenix-managed path.
    environmentFile = pkgs.writeText "caddy-secrets" ''
      CLOUDFLARE_DNS_API_TOKEN=$(<${config.age.secrets.cf-dns-ddclient.path})
    '';

    # Define your reverse proxies using a Caddyfile-like structure
    virtualHosts = {
      # Proxy for Actual Budget
      "actualbudget.bell-peppers.com" = {
        extraConfig = ''
          # Proxy requests to the Actual Budget server.
          # Caddy handles WebSockets automatically.
          reverse_proxy localhost:5006

          # Add security headers
          header {
            Strict-Transport-Security "max-age=31536000; includeSubDomains"
            X-Frame-Options "SAMEORIGIN"
            X-Content-Type-Options "nosniff"
            X-XSS-Protection "1; mode=block"
            Referrer-Policy "strict-origin-when-cross-origin"
          }
        '';
      };

      # Proxy for Headscale
      "headscale.bell-peppers.com" = {
        extraConfig = ''
          # Proxy requests to the Headscale server.
          # Caddy's reverse_proxy automatically handles the long-lived
          # connections and WebSockets needed by Headscale without extra config.
          reverse_proxy 127.0.0.1:8080

          # Add security headers
          header {
            Strict-Transport-Security "max-age=31536000; includeSubDomains"
            X-Frame-Options "SAMEORIGIN"
            X-Content-Type-Options "nosniff"
            X-XSS-Protection "1; mode=block"
            Referrer-Policy "strict-origin-when-cross-origin"
          }
        '';
      };
    };
  };
}
