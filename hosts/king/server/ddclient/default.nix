# ./king/configuration.nix (or relevant host config file)
{
  config,
  pkgs,
  ...
}: {
  systemd.services.ddclient = {
    # Wait for the specific service AND sops, not just the target
    after = ["NetworkManager-wait-online.service" "sops.service"];
    # Require it
    requires = ["NetworkManager-wait-online.service"];
    wants = ["network-online.target"];
  };
  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    username = "token";
    passwordFile = config.sops.secrets.cf_dns_token_file.path; # From previous step
    zone = "bell-peppers.com";
    domains = [
      "actualbudget.bell-peppers.com"
    ];
    ssl = true;
    interval = "60min";
    verbose = true;
    extraConfig = ''
      use=cmd
      cmd='${pkgs.curl}/bin/curl --interface eno1 -4 --silent --connect-timeout 10 https://api.ipify.org'
      ttl=1
    '';
  };
}
