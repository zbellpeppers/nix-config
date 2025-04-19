{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Gaming
    mangohud
    wineWowPackages.unstableFull
    winetricks
    protontricks
    mono
    bottles
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
    ventoy-full
    age
    sops
    ethtool
    dconf2nix
    vulkan-tools

    # GUI Tools
    kdePackages.partitionmanager
    ventoy-full
    fsearch
    ddcui
    kdePackages.yakuake
    kdePackages.kjournald
    via

    # Hardware Control
    openrgb-with-all-plugins
  ];
}
