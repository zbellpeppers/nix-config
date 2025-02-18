{config, ...}: {
  # Networking / Ethernet / Wifi Configuration
  networking = {
    # Enable Network Manager
    networkmanager.enable = true;

    # Enable NfTables - Updated Firewall
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 8384 22000];
      allowedUDPPorts = [22000 21027];
      allowedUDPPortRanges = [
        # Port Forward - KDEConnect
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedTCPPortRanges = [
        # Port Forward - KDEConnect
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
}
