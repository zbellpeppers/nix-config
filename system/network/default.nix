{
  config,
  pkgs,
  ...
}:
{
  systemd.services."NetworkManager-wait-online" = {
    enable = true;
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
      # 80 443 - http and https
      # 25565 - Minecraft
      allowedTCPPorts = [
        80
        443
        25565
      ];
      allowedUDPPorts = [ 25565 ];
    };
  };
}
