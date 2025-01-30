{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bash
    ./git
    ./tealdeer
    ./vscode
    ./kitty-terminal
  ];
  home.packages = with pkgs; [
    # CLI Tools
    wget
    pciutils
    p7zip
    fastfetch
    ddcutil
    nix-prefetch-github

    # Browser Related
    persepolis
    firedragon

    # Windows Emulation
    bottles

    # Entertainment
    stremio
    vlc

    # File Search
    fsearch

    #Communication
    equibop
    kdePackages.kdeconnect-kde

    # Office Apps
    kdePackages.skanpage
    onlyoffice-desktopeditors

    # Spell Checks and Dictionaries
    aspell
    aspellDicts.en
    hunspell
    hunspellDicts.en-us

    # Proton Apps
    protonmail-desktop
    protonvpn-gui

    # Programming
    alejandra
    gcc
    kdePackages.kate

    # General Apps
    speedcrunch
    obsidian

    # Gaming
    heroic
    wineWowPackages.unstableFull
    winetricks
    protontricks
    mangohud
    vkbasalt
    vkbasalt-cli

    # Torrenting
    calibre
    rqbit

    # Fonts
    roboto
    roboto-mono
    fira-code
  ];
}
