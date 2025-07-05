{
  pkgs,
  lib,
  ...
}:
{
  systemd.services."NetworkManager-wait-online" = {
    enable = true;
  };

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  services = {
    networkd-dispatcher = {
      enable = true;
      rules."50-tailscale" = {
        onState = [ "routable" ];
        script = ''
          ${lib.getExe pkgs.ethtool} -K eno1 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };
  };

  # Networking / Ethernet / Wifi Configuration
  networking = {
    # Enable Network Manager
    networkmanager = {
      enable = true;
      plugins = [
        pkgs.networkmanager-openvpn
      ];
    };

    # Enable NfTables - Updated Firewall
    nftables.enable = true;
    firewall = {
      enable = true;
      # Allow tailscale traffic
      trustedInterfaces = [ "tailscale0" ];
      # 80 443 - http and https
      # 25565 - Minecraft
      # 41641 - Tailscale
      # 8080 - Headscale
      # 5006 - actual_budget
      allowedTCPPorts = [
        80
        443
        8080
        25565
      ];
      allowedUDPPorts = [
        80
        443
        41641
      ];
    };
  };
}
