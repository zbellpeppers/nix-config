{pkgs, ...}: {
  programs.gnome-shell = {
    enable = true;
    theme = {
      name = "Orchis";
      package = pkgs.orchis-theme;
    };
  };

  xdg.desktopEntries = {
    "smartcode-stremio" = {
      name = "Stremio";
      exec = "stremio";
      icon = "stremio";
    };
    "equibop" = {
      name = "Discord";
      exec = "equibop";
      icon = "discord";
    };
    "codium" = {
      name = "Code - OSS";
      exec = "codium";
      icon = "code-oss";
    };
    "org.speedcrunch.SpeedCrunch" = {
      name = "Calculator";
      exec = "speedcrunch";
      icon = "org.gnome.Calculator";
    };
    "kitty" = {
      name = "Terminal";
      exec = "kitty";
      icon = "terminal";
    };
  };
}
