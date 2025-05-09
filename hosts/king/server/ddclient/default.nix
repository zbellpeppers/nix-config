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
    usev4 = "webv4, webv4=ipify-ipv4";
    usev6 = "";
    protocol = "cloudflare";
    username = "token";
    passwordFile = config.age.secrets.cf-ddclient-token.path;
    zone = "bell-peppers.com";
    domains = [
      "actualbudget.bell-peppers.com"
    ];
    ssl = true;
    interval = "60min";
    verbose = true;
    extraConfig = ''
      ttl=1
    '';
  };
}
