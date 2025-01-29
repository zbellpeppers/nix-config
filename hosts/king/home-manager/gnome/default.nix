{pkgs, ...}: {
  home.packages = with pkgs; [
    orchis-theme
    papirus-icon-theme
    papirus-folders
    dconf2nix
  ];

  programs.gnome-shell = {
    enable = true;
    theme = {
      name = "Orchis-Dark-Compact";
      package = pkgs.orchis-theme;
    };
    extensions = [
      {package = pkgs.gnomeExtensions.dash-to-panel;}
    ];
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
  dconf.settings = {
  };
}
