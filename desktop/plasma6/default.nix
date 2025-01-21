{pkgs, ...}: {
  qt.platformTheme = "kde";
  environment.plasma6.excludePackages = [
    pkgs.kdePackages.oxygen
    pkgs.kdePackages.elisa
  ];
  services = {
    # Display Manager Configuration
    displayManager = {
      sddm = {
        enable = true;
        theme = "~/Documents/monochrome";
        wayland.enable = true;
        wayland.compositor = "kwin";
      };
    };

    # Keyboard Mapping
    xserver = {
      xkb = {
        layout = "us,us";
        variant = "workman,";
        options = "grp:win_space_toggle,caps:capslock";
      };
      # Configures How Fast Repeat Activates and How Often it Happens
      autoRepeatDelay = 275;
      autoRepeatInterval = 32;
    };

    # Enable KDE Desktop Environment
    desktopManager.plasma6.enable = true;
    desktopManager.plasma6.enableQt5Integration = true;
  };
}
