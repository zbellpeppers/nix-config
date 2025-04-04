# ./king/configuration.nix (or relevant host config file)
{
  config,
  pkgs,
  ...
}: {
  systemd.services.ddclient = {
    # Ensure networking is fully up, including the interface we bind to
    after = ["network-online.target" "sops.service"];
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
      cmd='${pkgs.curl}/bin/curl --interface eno1 -4 --silent https://api.ipify.org'
      ttl=1
    '';
  };
}
