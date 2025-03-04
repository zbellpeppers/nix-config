{config, ...}: {
  # Networking / Ethernet / Wifi Configuration
  networking = {
    hostName = "zach-nixos";
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
    passwordFile = "/home/zachary/Desktop/All/Documents/Accounting/ActualBudget/cloudflare-token.txt";
    domains = ["actualbudget.bell-peppers.com"];
    usev4 = "web";
    extraConfig = ''
      web=https://api.ipify.org
      web-skip='IP Address'
      ssl=yes
      zone=bell-peppers.com
    '';
  };
}
