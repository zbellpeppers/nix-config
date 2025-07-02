{ config, ... }:

{
  # ACME for SSL Certificates via Cloudflare
  security.acme = {
    acceptTerms = true;
    defaults.email = "zbellpeppers@pm.me";
  };

  security.acme.certs."bell-peppers.com" = {
    dnsProvider = "cloudflare";
    # This credentials file needs to be in INI format.
    credentialsFile = config.age.secrets.cloudflare-acme-credentials.path;
    domain = "homeassis.bell-peppers.com";
    extraDomainNames = [ "headscale.bell-peppers.com" ];
  };

  # NGINX Service Configuration
  services.nginx = {
    enable = true;

    # These options replicate best practices for security and performance.
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Define virtual hosts
    virtualHosts = {
      "homeassis.bell-peppers.com" = {
        # Automatically use the ACME cert and redirect HTTP to HTTPS.
        forceSSL = true;
        enableACME = true;

        locations."/".proxyPass = "http://localhost:8123";
      };

      "headscale.bell-peppers.com" = {
        # Automatically use the ACME cert and redirect HTTP to HTTPS.
        forceSSL = true;
        enableACME = true;

        locations."/".proxyPass = "http://localhost:8080";

        # Additional headers for headscale
        extraConfig = ''
          add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        '';
      };
    };
  };
}
