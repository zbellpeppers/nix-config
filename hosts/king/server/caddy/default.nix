{ ... }:
{
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
    ]; # HTTP & HTTPS
  };
  # caddy-env-token should contain:
  # CF_API_TOKEN=your_actual_api_token_here
  # age.secrets.caddy-cloudflare-credentials = {
  #   file = ../../../../secrets/caddy-env-token.age;
  # };

  # Caddy service
  services.caddy = {
    enable = true;
    # environmentFile = config.age.secrets.caddy-cloudflare-credentials.path;
    virtualHosts = {
      "headscale.bell-peppers.com" = {
        extraConfig = ''
          reverse_proxy localhost:8080
        '';
      };
    };
  };
}
