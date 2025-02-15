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
    ./fish
    ./rio-term
  ];
  home.packages = with pkgs; [
    # Remote Access
    rustdesk-flutter

    # Browser Related
    persepolis
    xclicker
    brave

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
    bottles
    (lutris.override {
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
    })

    # Torrenting
    calibre
    qbittorrent-enhanced
  ];
}
