{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./boot
    ./flatpak
    ./hardware
  ];
  # Host-specific configuration goes here
  networking.hostName = "queen";

  # User creation
  users.users.sarah = {
    isNormalUser = true;
    description = "Sarah Nicole Smallwood";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "nix"
      "lp"
      "scanner"
      "i2c"
    ];
  };

  services = {
    # Set default keyboard layout
    xserver = {
      videoDrivers = [ "amdgpu" ];
      xkb = {
        layout = "us,us";
        variant = ",workman";
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

  system.stateVersion = "25.11";
}
