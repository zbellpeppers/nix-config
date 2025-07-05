{ pkgs, ... }:
let
  nftablesRules = pkgs.writeText "vpn-bypass-rules.nft" ''
    table inet mangle {
      chain prerouting {
        type filter hook prerouting priority mangle;
        iifname "eno1" tcp dport 443 meta mark set 1;
      }
    }
  '';
in
{
  systemd.services.vpn-bypass = {
    description = "Apply custom routing to bypass VPN for web services";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "vpn-bypass-script" ''
        #!${pkgs.bash}/bin/bash
        set -e

        # A. Load the nftables ruleset.
        ${pkgs.nftables}/bin/nft flush table inet mangle >/dev/null 2>&1 || true
        ${pkgs.nftables}/bin/nft -f ${nftablesRules}

        # B. THIS IS THE FIX: Delete the old rule first, ignoring errors if it doesn't exist.
        ${pkgs.iproute2}/bin/ip rule del priority 99 >/dev/null 2>&1 || true

        # C. Now, safely add the rule without fear of it already existing.
        ${pkgs.iproute2}/bin/ip rule add fwmark 1 lookup 100 priority 99

        # D. The route command remains the same, as 'replace' is already safe.
        ${pkgs.iproute2}/bin/ip route replace default via 192.168.1.254 dev eno1 table 100
      '';
    };
  };
  # secret for below
  age.secrets = {
    cloudflare-acme-credentials = {
      # The contents should be 'CLOUDFLARE_DNS_API_TOKEN=YOUR_TOKEN'
      file = ../../../../secrets/cloudflare-dns-token.age;
      path = "/run/secrets/cloudflare-acme-credentials";
      owner = "acme";
      group = "acme";
    };
  };
  # ACME for SSL Certificates via Cloudflare
  security.acme = {
    acceptTerms = true;
    defaults.email = "zbellpeppers@pm.me";
    certs."bell-peppers.com" = {
      dnsProvider = "cloudflare";
      credentialFiles = {
        "CLOUDFLARE_DNS_API_TOKEN_FILE" = "/run/secrets/cloudflare-acme-credentials";
      };
      domain = "traccar.bell-peppers.com";
      extraDomainNames = [
        "actualbudget.bell-peppers.com"
      ];
    };
  };

  # NGINX Service Configuration
  users.users.nginx.extraGroups = [ "acme" ];
  services.nginx = {
    enable = true;

    # Per nixos wiki
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Define virtual hosts
    virtualHosts = {
      "haos.bell-peppers.com" = {
        forceSSL = true;
        useACMEHost = "bell-peppers.com";
        locations."/" = {
          proxyPass = "http://127.0.0.1:8123";
          # proxyWebsockets = true; # Required for Home Assistant UI to function correctly
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
          '';
        };
      };
      "headscale.bell-peppers.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://localhost:8080";
        # Additional headers for headscale
        extraConfig = ''
          proxy_headers_hash_max_size 512;
          add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
          add_header X-Frame-Options "SAMEORIGIN" always;
          add_header X-Content-Type-Options "nosniff" always;
          add_header Referrer-Policy "strict-origin-when-cross-origin" always;
        '';
      };
      "traccar.bell-peppers.com" = {
        forceSSL = true;
        useACMEHost = "bell-peppers.com";
        locations."/".proxyPass = "http://localhost:8082";
        # Include a proxy for web socket
        locations."/api/socket" = {
          proxyPass = "http://localhost:8082/api/socket";
          proxyWebsockets = true;
        };
        extraConfig = ''
          proxy_headers_hash_max_size 512;
        '';
      };
    };
  };
}
