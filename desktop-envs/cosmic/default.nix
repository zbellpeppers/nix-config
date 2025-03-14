{pkgs, ...}: {
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
  ];
  location.provider = "manual";
  location.latitude = 33.734497;
  location.longitude = -84.111847;
  services.redshift = {
    enable = true;
    # location.latitude = 33.734497;
    # location.longitude = -84.111847;
    brightness = {
      day = "1";
      night = "1";
    };
    temperature = {
      day = 2800;
      night = 2800;
    };
  };
}
