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
    ./git
    ./tealdeer
    ./vscode
    ./wezterm
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

    # Browser Related
    persepolis
    cheese

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
    appflowy

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
    python313FreeThreading
    python313Packages.pip

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
    roboto
    roboto-mono
    fira-code
  ];
}
