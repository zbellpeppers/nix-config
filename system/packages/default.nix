{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Gaming
    mangohud
    wineWowPackages.full
    winetricks
    protontricks
    mono
    lutris

    # CLI Tools
    wget
    pciutils
    p7zip
    fastfetch
    ddcutil
    unrar
    appimage-run
    efibootmgr
    nix-prefetch-git
    nix-prefetch-github
    eza
    bat
    hwinfo
    tealdeer
    grc
    wl-clipboard-rs
    age
    sops
    ethtool
    dconf2nix
    vulkan-tools
    inputs.ragenix.packages.x86_64-linux.default
    exiftool
    imagemagick

    # GUI Tools
    kdePackages.partitionmanager
    fsearch
    ddcui
    kdePackages.yakuake
    kdePackages.kjournald
    via

    # Hardware RGB Control
    openrgb-with-all-plugins
  ];
}
