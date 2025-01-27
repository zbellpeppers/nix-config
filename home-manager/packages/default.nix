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

    firefox

    # Windows
    bottles

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
    vkbasalt
    vkbasalt-cli

    # Torrenting
    calibre
    rqbit

    # Fonts
    roboto
    roboto-mono
    roboto-serif
    fira-code
  ];
}
