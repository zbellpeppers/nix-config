{
  config,
  pkgs,
  ...
}: {
  # To build use: nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=default.nix
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix>
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_lqx;
  hardware.i2c.enable = true;
  # Keyboard Layout
  services = {
    # Enable and set redshift to 2200
    redshift = {
      enable = true;
      temperature.night = 2200;
      temperature.day = 2200;
      brightness.day = "0.4";
      brightness.night = "0.4";
    };
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

  # Add additional packages to the installation image
  environment.systemPackages = with pkgs; [
    # KDE Partition Manager
    kdePackages.partitionmanager

    # File transfer and compression utilities
    rsync
    p7zip

    # BTRFS tools
    btrfs-progs
    btrfs-snap

    # Additional useful tools
    git
    neofetch
    kdePackages.kate # KDE text editor
    micro
  ];

  # Ensure BTRFS support is enabled
  boot.supportedFilesystems = ["btrfs" "ntfs"];
}
