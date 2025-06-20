{
  pkgs,
  ...
}:
{
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon_MF460_Series_UFR_II";
        location = "Kitchen";
        description = "Canon_Laser_Printer";
        deviceUri = "ipp://192.168.1.109/ipp/print";
        model = "CNRCUPSMF460ZK.ppd";
      }
    ];
  };
  # Enable Printing & Specify Drivers
  services.printing = {
    enable = true;
    drivers = [
      pkgs.canon-cups-ufr2
    ];
  };
  # SCANNER CONFIGURATION
  # Enable Network Device Discovery - NixOS Doesn't Natively Support Canon ImageClass
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  # Enable Sane and Open Firewall
  hardware.sane = {
    enable = true;
    openFirewall = true;
  };
  # Provides IP for Specific Scanner
  services.saned = {
    enable = true;
    extraConfig = "192.168.1.109";
  };
}
