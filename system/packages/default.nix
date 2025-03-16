{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
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
    ventoy-full
    age
    ethtool
    dconf2nix

    # GUI Tools
    kdePackages.partitionmanager
    ventoy-full
    fsearch
    ddcui
    kdePackages.konsole
    kdePackages.yakuake

    # Gaming
    mangohud

    # Hardware Control
    openrgb-with-all-plugins
  ];
}
