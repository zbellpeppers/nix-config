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

    # GUI Tools
    kdePackages.partitionmanager
    ventoy-full
    fsearch
    ddcui

    # Gaming
    mangohud

    # Hardware Control
    openrgb-with-all-plugins
  ];
}
