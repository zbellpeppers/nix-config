{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Nix specific tooling
    nixfmt-rfc-style
    nixd
    inputs.ragenix.packages.x86_64-linux.default
    dconf2nix
    nix-prefetch-git
    nix-prefetch-github

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
    dig
    clinfo

    # GUI Tools
    kdePackages.partitionmanager
    kdePackages.yakuake
    kdePackages.kjournald

    # Server tools
    nss_latest

    # Hardware RGB Control
    openrgb-with-all-plugins
  ];
}
