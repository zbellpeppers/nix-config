{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us,us";
      variant = "workman,";
      options = "grp:win_space_toggle,caps:capslock";
    };
    autoRepeatDelay = 275;
    autoRepeatInterval = 32;
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-shell-extensions
    gnome-builder
  ];

  programs.dconf.enable = true;
  services.gnome = {
    gnome-browser-connector.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    geary
    gnome-tour
    gnome-user-docs
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-console
    gnome-contacts
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
  ];
}
