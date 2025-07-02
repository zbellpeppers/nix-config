{
  pkgs,
  ...
}:
{
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
