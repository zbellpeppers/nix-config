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
          # Forward original host and protocol information
          header_up X-Forwarded-Port 443
          header_up X-Forwarded-Proto https
        }
      '';
    };
  };
}
