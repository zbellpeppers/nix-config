{ ... }:
{
  networking.firewall = {
    # HTTP & HTTPS
    allowedTCPPorts = [
      80
      443
    ];
  };

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
