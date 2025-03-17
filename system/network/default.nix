{config, ...}: {
  # Networking / Ethernet / Wifi Configuration
  networking = {
    # Enable Network Manager
    networkmanager.enable = true;

    # Enable NfTables - Updated Firewall
    nftables.enable = true;
    firewall = {
      enable = true;
      # 80 443 - http and https
      # 5006 - Actual Budget
      allowedTCPPorts = [80 443 5006];
      allowedUDPPorts = [];
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
