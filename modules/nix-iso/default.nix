{
  config,
  pkgs,
  ...
}: {
  # To build use: nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=iso.nix
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix>
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages = pkgs.linuxPackages_6_12;

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
  boot.supportedFilesystems = ["btrfs"];
}
