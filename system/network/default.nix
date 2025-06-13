{
  pkgs,
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
      allowedTCPPorts = [
        80
        443
        25565
      ];
      allowedUDPPorts = [
        41641
      ];
    };
  };
}
