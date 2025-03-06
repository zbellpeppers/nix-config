{
  config,
  pkgs,
  inputs,
  ...
}: let
  # appflowy = pkgs.callPackage ../../../../modules/appflowy {};
in {
  imports = [
    ./bash
    ./tealdeer
    ./vscode
    ./fish
    ./micro
  ];
  home.packages = with pkgs; [
    # Remote Access
    rustdesk-flutter

    # Browser Related
    persepolis
    xclicker

    # Entertainment
    vlc

    # File Search
    fsearch

    #Communication
    vesktop
    kdePackages.kdeconnect-kde

    # Office Apps
    kdePackages.skanpage

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
