{
  config,
  pkgs,
  inputs,
  ...
}: let
  appflowy = pkgs.callPackage ../../../../modules/appflowy {};
in {
  imports = [
    ./bash
    ./tealdeer
    ./vscode
  ];
  home.packages = with pkgs; [
    # CLI Tools
    wget
    pciutils
    p7zip
    fastfetch
    ddcutil
    unrar
    podman-desktop
    appimage-run
    clinfo
    efibootmgr
    konsave

    # Browser Related
    persepolis
    xclicker

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
    wineWowPackages.waylandFull
    winetricks
    protontricks
    mono
    mangohud
    r2modman
    vkbasalt
    vkbasalt-cli

    # Torrenting
    calibre
    qbittorrent-enhanced

    # Fonts
    fira-code
  ];
}
