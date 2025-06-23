{ config, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-2D7dnG50CwtCho+U+iHmSj2w14zllQXPjmTHr6lJZ/A=";
    };
    environmentFile = config.age.secrets.cloudflare-env-api-caddy.path;
    # The file must export CLOUDFLARE_DNS_API_TOKEN=xxxxxxxx
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_DNS_API_TOKEN}
    '';

    virtualHosts = {
      "actualbudget.bpf.lan".extraConfig = ''
        tls internal
        encode gzip zstd
        reverse_proxy http://localhost:5006
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
