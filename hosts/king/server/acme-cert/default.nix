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
      group = "nginx";
      webroot = null;
    };
  };
}
