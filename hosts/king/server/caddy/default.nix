{...}: {
  # Enable Caddy service
  services.caddy = {
    enable = true;
    email = "zbellpeppers@pm.me";
    # Reverse proxy for actual budget server.
    virtualHosts."actualbudget.bell-peppers.com" = {
      listenAddresses = [
        "localhost:5006"
      ];
      extraConfig = ''
        encode gzip zstd
      '';
    };
  };
}
