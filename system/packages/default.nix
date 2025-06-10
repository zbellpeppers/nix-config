{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Nix specific tooling
    nixfmt-rfc-style
    inputs.ragenix.packages.x86_64-linux.default
    dconf2nix
    nix-prefetch-git
    nix-prefetch-github

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
    eza
    bat
    hwinfo
    tealdeer
    grc
    wl-clipboard-rs
    age
    sops
    ethtool
    vulkan-tools
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
