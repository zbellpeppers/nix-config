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
    shell = pkgs.fish;
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
    ];
  };

  services = {
    # Set default keyboard layout
    xserver = {
      xkb = {
        extraLayouts.soul = {
          description = "Soul layout";
          languages = ["eng"];
          symbolsFile = ./soul;
        };
        layout = "soul,us";
        variant = ",";
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

  system.stateVersion = "25.05";
}
