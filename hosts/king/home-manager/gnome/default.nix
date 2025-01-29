{
  pkgs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    orchis-theme
    papirus-icon-theme
    papirus-folders
    dconf2nix
    gnome-tweaks
    gnome-shell-extensions
    gnome-builder
    gnomeExtensions.dash-to-panel
  ];

  programs.gnome-shell = {
    enable = true;
    theme = {
      name = "Orchis-Dark-Compact";
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
