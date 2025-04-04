{...}: {
  # Enable Caddy service
  services.caddy = {
    enable = true;

    # Configure virtual host for your domain
    virtualHosts."actualbudget.bell-peppers.com" = {
      extraConfig = ''
        encode gzip zstd
        reverse_proxy 127.0.0.1:5006
      '';
    };
  };
}
