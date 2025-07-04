{ pkgs, config, ... }:
{
  # caddy-env-token should contain:
  # CF_API_TOKEN=your_actual_api_token_here
  age.secrets.caddy-cloudflare-credentials = {
    file = ../../../../secrets/caddy-env-token.age;
  };

  # Caddy service
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-2D7dnG50CwtCho+U+iHmSj2w14zllQXPjmTHr6lJZ/A=";
    };
    environmentFile = config.age.secrets.caddy-cloudflare-credentials.path;
    virtualHosts = {
      "haos.bell-peppers.com" = {
        extraConfig = ''
          tls {
            dns cloudflare {env.CF_API_TOKEN}
          }
          reverse_proxy localhost:8123
        '';
      };
      "traccar.bell-peppers.com" = {
        extraConfig = ''
          tls {
            dns cloudflare {env.CF_API_TOKEN}
          }
          reverse_proxy localhost:8082
        '';
      };
      "headscale.bell-peppers.com" = {
        extraConfig = ''
          # Proxy to headscale.
          reverse_proxy localhost:8080
          # Replicating the extra headers from your Nginx config.
          header {
              Strict-Transport-Security "max-age=31536000; includeSubDomains"
              X-Frame-Options "SAMEORIGIN"
              X-Content-Type-Options "nosniff"
              Referrer-Policy "strict-origin-when-cross-origin"
          }
        '';
      };
      "actualbudget.bell-peppers.com" = {
        extraConfig = ''
          tls {
            dns cloudflare {env.CF_API_TOKEN}
          }
          encode gzip zstd
          reverse_proxy localhost:5006
        '';
      };
    };
  };
}
