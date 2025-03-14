{config, ...}: {
  security.acme = {
    defaults.email = "zbellpeppers@pm.me";
    acceptTerms = true;
    # Define the certificate for actualbudget.bell-peppers.com
    certs."actualbudget.bell-peppers.com" = {
      domain = "actualbudget.bell-peppers.com";
      dnsProvider = "cloudflare";
      environmentFile = config.age.secrets.actualbudget-nginx-apitoken.path;
      # Optional: Set the group that can access the certificate
      # group = "nginx";
    };
  };
  # services.nginx = {
  #   enable = true;
  #   # recommendedProxySettings = true;
  #   # recommendedTlsSettings = true;
  #   virtualHosts."actualbudget.bell-peppers.com" = {
  #     listen = [
  #       {
  #         addr = "0.0.0.0";
  #         port = 443;
  #         ssl = true;
  #       }
  #       {
  #         addr = "0.0.0.0";
  #         port = 80;
  #       }
  #     ];
  #     forceSSL = true;
  #     useACMEHost = "actualbudget.bell-peppers.com";
  #     locations."/" = {
  #       proxyPass = "http://127.0.0.1:5006";
  #       proxyWebsockets = true; # If Actual Budget uses WebSockets
  #       extraConfig = ''
  #         proxy_set_header Host $host;
  #         proxy_set_header X-Real-IP $remote_addr;
  #         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  #         proxy_set_header X-Forwarded-Proto $scheme;
  #       '';
  #     };
  #   };
  # };
}
