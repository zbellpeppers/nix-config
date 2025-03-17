{
  config,
  pkgs,
  ...
}: let
  domain = "bell-peppers.com";
in {
  services = {
    tailscale = {
      enable = true;
      port = 0;
      useRoutingFeatures = "both";
      openFirewall = true;
    };

    headscale = {
      enable = true;
      address = "0.0.0.0";
      user = "headscale";
      group = "headscale";
      port = 8080;
      settings = {
        log.level = "debug";
        log.format = "text";
        server_url = "https://headscale.${domain}";
        dns = {
          magic_dns = true;
          base_domain = "${domain}";
        };
      };
    };

    nginx.virtualHosts."headscale.${domain}" = {
      forceSSL = true;
      enableACME = true;
      locations."/" = {
        proxyPass = "http://localhost:${toString config.services.headscale.port}";
        proxyWebsockets = true;
      };
    };
  };
  environment.systemPackages = [config.services.headscale.package];
}
