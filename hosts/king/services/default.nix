{...}: {
  services = {
    actual = {
      enable = true;
      openFirewall = true;
      settings = {
        port = 5006;
      };
    };
    redshift = {
      enable = true;
      temperature.night = 2200;
      temperature.day = 2200;
      brightness.day = "0.4";
      brightness.night = "0.4";
    };
  };
}
