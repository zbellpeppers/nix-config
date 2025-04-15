{...}: {
  # Enable Caddy service
  services.caddy = {
    enable = true;
    email = "zbellpeppers@pm.me";
    # Reverse proxy for actual budget server.
    virtualHosts."actualbudget.bell-peppers.com" = {
      extraConfig = ''
        encode gzip zstd
        reverse_proxy localhost:5006
      '';
    };
  };
}
