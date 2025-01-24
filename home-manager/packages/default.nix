{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./bash
    ./git
    ./tealdeer
    ./vscode
    ./foot-terminal
  ];
  home.packages = with pkgs; [
    # CLI Tools
    wget
    pciutils
    p7zip
    fastfetch
    ddcutil
    vkbasalt
    vkbasalt-cli

    # Entertainment
    stremio

    # File Search
    fsearch
    kdePackages.filelight

    #Communication
    equibop
    kdePackages.kdeconnect-kde

    # Office Suite
    libreoffice-qt-fresh
    hunspell
    hunspellDicts.en-us
    kdePackages.skanpage

    # Spell Checks and Dictionaries
    aspell
    aspellDicts.en

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
    shadps4

    # Torrenting
    calibre
    qbittorrent-enhanced

    # Fonts
    roboto
    roboto-mono
    roboto-serif
    fira-code
  ];
}
