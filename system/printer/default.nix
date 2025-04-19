{
  config,
  pkgs,
  ...
}: {
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Canon_MF460_Series_UFR_II";
        location = "Kitchen";
        description = "Canon_Laser_Printer";
        deviceUri = "dnssd://Canon%20MF460%20Series._ipp._tcp.local/?uuid=6d4ff0ce-6b11-11d8-8020-6c3c7cf60976";
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
    extraConfig = "192.168.1.83";
  };
}
