{
  config,
  pkgs,
  ...
}: let
  # Create the IPv4 script
  getIPv4Script = pkgs.writeShellScript "get-ipv4" ''
    #!/bin/sh

    # --- CONFIGURATION ---
    REAL_INTERFACE="eno1"
    CHECK_URL="https://cloudflare.com/cdn-cgi/trace"

    # --- SCRIPT LOGIC ---
    TRACE_OUTPUT=$(${pkgs.curl}/bin/curl --silent --fail -4 --interface "$REAL_INTERFACE" "$CHECK_URL")
    CURL_EXIT_CODE=$?

    if [ $CURL_EXIT_CODE -eq 0 ] && [ -n "$TRACE_OUTPUT" ]; then
        EXTRACTED_IP=$(echo "$TRACE_OUTPUT" | ${pkgs.gnugrep}/bin/grep '^ip=' | ${pkgs.coreutils}/bin/cut -d= -f2)

        if [ -n "$EXTRACTED_IP" ] && [[ "$EXTRACTED_IP" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo "$EXTRACTED_IP"
            exit 0
        else
            echo "Error: Could not parse valid IPv4 from Cloudflare trace (IP found: '$EXTRACTED_IP')" >&2
            exit 1
        fi
    else
        echo "Error fetching IPv4 trace via $REAL_INTERFACE (curl code: $CURL_EXIT_CODE)" >&2
        exit 1
    fi
  '';

  # Create the IPv6 script
  getIPv6Script = pkgs.writeShellScript "get-ipv6" ''
    #!/bin/sh

    # --- CONFIGURATION ---
    REAL_INTERFACE="eno1"
    CHECK_URL="https://cloudflare.com/cdn-cgi/trace"

    # --- SCRIPT LOGIC ---
    TRACE_OUTPUT=$(${pkgs.curl}/bin/curl --silent --fail -6 --interface "$REAL_INTERFACE" "$CHECK_URL")
    CURL_EXIT_CODE=$?

    if [ $CURL_EXIT_CODE -eq 0 ] && [ -n "$TRACE_OUTPUT" ]; then
        EXTRACTED_IP=$(echo "$TRACE_OUTPUT" | ${pkgs.gnugrep}/bin/grep '^ip=' | ${pkgs.coreutils}/bin/cut -d= -f2)

        if [ -n "$EXTRACTED_IP" ]; then
            echo "$EXTRACTED_IP"
            exit 0
        else
            echo "Error: Could not parse IP from Cloudflare trace" >&2
            exit 1
        fi
    else
        echo "Error fetching IPv6 trace via $REAL_INTERFACE (curl code: $CURL_EXIT_CODE)" >&2
        exit 1
    fi
  '';
in {
  systemd.services.ddclient = {
    after = ["NetworkManager-wait-online.service"];
    requires = ["NetworkManager-wait-online.service"];
    wants = ["network-online.target"];
  };
  services.ddclient = {
    enable = true;
    usev4 = "cmdv4, cmdv4='${getIPv4Script}'";
    usev6 = "cmdv6, cmdv6='${getIPv6Script}'";
    protocol = "cloudflare";
    username = "token";
    passwordFile = config.age.secrets.cf-dns-ddclient.path;
    zone = "bell-peppers.com";
    domains = [
      "actualbudget.bell-peppers.com"
    ];
    ssl = true;
    interval = "10min";
    verbose = true;
    extraConfig = ''
      ttl=1
    '';
  };
}
