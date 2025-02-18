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
    zsh
    wl-clipboard-rs
    inputs.agenix.packages.x86_64-linux.default

    # Gaming
    mangohud

    # Hardware Control
    openrgb-with-all-plugins
  ];
}
