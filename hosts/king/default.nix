{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./boot
    ./flatpak
    ./hardware
    ./server
  ];
  # Host-specific configuration goes here
  networking.hostName = "king";

  # User creation
  users.users.zachary = {
    isNormalUser = true;
    description = "Zachary Bell Peppers";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "nix"
      "lp"
      "scanner"
      "podman"
      "i2c"
      "nginx"
    ];
  };

  programs.zsh.enable = true;

  services = {
    # Set default keyboard layout
    xserver = {
      xkb = {
        layout = "us,us";
        variant = "workman,";
        options = "grp:win_space_toggle,caps:capslock";
      };
      autoRepeatDelay = 275;
      autoRepeatInterval = 32;
    };
  };

  environment = {
    systemPackages = with pkgs; [
    ];
    # Set default terminal editor to micro
    variables = {
      EDITOR = "micro";
      VISUAL = "micro";
    };
  };

  # Set micro to default sudoeditor
  security.sudo.extraConfig = ''
    Defaults editor=${pkgs.micro}/bin/micro
    Defaults pwfeedback
  '';

  # Uses local time
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "America/New_York";
  };

  # Select Internationalisation Properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

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
      day = 2200;
      night = 2200;
    };
  };

  system.stateVersion = "25.05";
}
