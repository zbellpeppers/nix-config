{ config, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-Gsuo+ripJSgKSYOM9/yl6Kt/6BFCA6BuTDvPdteinAI=";
    };
    environmentFile = config.age.secrets.cloudflare-env-api-caddy.path;
    # The file must export CLOUDFLARE_DNS_API_TOKEN=xxxxxxxx
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_DNS_API_TOKEN}
    '';

    virtualHosts = {
      "actualbudget.bell-peppers.com".extraConfig = ''
        # Reverse proxy + WebSockets (Caddy upgrades automatically)
        reverse_proxy http://localhost:5006
        # Security headers
        header {
          Strict-Transport-Security "max-age=31536000; includeSubDomains"
          X-Frame-Options "SAMEORIGIN"
          X-Content-Type-Options "nosniff"
          X-XSS-Protection "1; mode=block"
          Referrer-Policy "strict-origin-when-cross-origin"
        }
      '';
      "headscale.bell-peppers.com".extraConfig = ''
        reverse_proxy 0.0.0.0:8080

        # Optional: extra proxy headers; most are set automatically
        header {
          Strict-Transport-Security "max-age=31536000; includeSubDomains"
          X-Frame-Options "SAMEORIGIN"
          X-Content-Type-Options "nosniff"
          Referrer-Policy "strict-origin-when-cross-origin"
        }
      '';
    };
  };
}
