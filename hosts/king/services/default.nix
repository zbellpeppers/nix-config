{ ... }:
{
  services = {
    redshift = {
      enable = true;
      temperature.night = 2200;
      temperature.day = 2200;
    };
  };
}
