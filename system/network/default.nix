{config, ...}: {
  # Networking / Ethernet / Wifi Configuration
  networking = {
    # Enable Network Manager
    networkmanager.enable = true;

    # Enable NfTables - Updated Firewall
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [80 443 5006 8384 22000];
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
  services.ddclient = {
    enable = true;
    protocol = "cloudflare";
    username = "token";
    zone = "bell-peppers.com";
    passwordFile = "/home/zachary/Desktop/All/Documents/Accounting/ActualBudget/cloudflare-token.txt";
    domains = ["actualbudget.bell-peppers.com"];
    interval = "5min";
    usev6 = "webv6";
    usev4 = "webv4";
  };
}
