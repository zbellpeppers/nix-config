{...}: {
  # Enable Caddy service
  services.caddy = {
    enable = true;

    # Configure virtual host for your domain
    virtualHosts."actualbudget.bell-peppers.com" = {
      extraConfig = ''
        # This enables automatic HTTPS
        # Reverse proxy to your Actual Budget container
        reverse_proxy 127.0.0.1:5006 {
        }
      '';
    };
  };
}
