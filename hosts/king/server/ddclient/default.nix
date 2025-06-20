{ config, pkgs, ... }:

let
  # ——————————————————————————————————————————————————————
  # Helper scripts
  # ——————————————————————————————————————————————————————
  getIPv4Script = pkgs.writeShellScript "get-ipv4" ''
    #!${pkgs.stdenv.shell}
    # Query Cloudflare’s trace endpoint *with IPv4 only* and on the
    # real interface (so the VPN tunnel is bypassed).
    EXTRACTED_IP=$(
      ${pkgs.curl}/bin/curl -s --fail -4 --interface eno1 \
        https://cloudflare.com/cdn-cgi/trace  | \
      ${pkgs.gnugrep}/bin/grep '^ip='           | \
      ${pkgs.coreutils}/bin/cut  -d= -f2
    )
    test -n "$EXTRACTED_IP" && echo "$EXTRACTED_IP"
  '';

  getIPv6Script = pkgs.writeShellScript "get-ipv6" ''
    #!${pkgs.stdenv.shell}
    EXTRACTED_IP=$(
      ${pkgs.curl}/bin/curl -s --fail -6 --interface eno1 \
        https://cloudflare.com/cdn-cgi/trace  | \
      ${pkgs.gnugrep}/bin/grep '^ip='           | \
      ${pkgs.coreutils}/bin/cut  -d= -f2
    )
    test -n "$EXTRACTED_IP" && echo "$EXTRACTED_IP"
  '';
in
{
  services.ddclient = {
    enable = true;

    # --- Tell ddclient *how* to discover an address ----------------
    # “cmd” means “run an external command”.
    usev4 = "cmdv4, cmd=${getIPv4Script}";
    usev6 = "cmdv6, cmd=${getIPv6Script}";

    # --- Cloudflare update parameters ------------------------------
    protocol = "cloudflare";
    username = "token";
    passwordFile = config.age.secrets.cf-dns-ddclient.path;
    zone = "bell-peppers.com";
    domains = [
      "actualbudget.bell-peppers.com"
      "headscale.bell-peppers.com"
    ];
    ssl = true; # use HTTPS to talk to Cloudflare
    interval = "10m"; # how often ddclient re-checks the IP
    verbose = true;
    extraConfig = ''
      ttl=1             # any additional raw ddclient.conf lines
    '';
  };
}
