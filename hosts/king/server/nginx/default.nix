{config, ...}: {
  # Enable Nginx
  services.nginx = {
    enable = true;

    # Recommended security settings
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    # Configure the virtual host for Actual Budget
    virtualHosts."actualbudget.bell-peppers.com" = {
      enableACME = true; # Use the ACME certificate
      forceSSL = true; # Redirect HTTP to HTTPS

      # Configure proxy to the Actual Budget Podman container
      locations."/" = {
        proxyPass = "http://127.0.0.1:5006"; # Assuming Actual Budget runs on port 5006
        proxyWebsockets = true; # Enable if Actual Budget uses WebSockets
      };
    };
  };

  # Ensure Nginx can read the certificates
  security.acme.certs."actualbudget.bell-peppers.com".group = "nginx";

  # Open firewall ports
  networking.firewall.allowedTCPPorts = [80 443];
}
