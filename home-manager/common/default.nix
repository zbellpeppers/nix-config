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
    ./fish
    ./ghostty
    ./micro
    ./tealdeer
    ./vscode
  ];
  home.packages = with pkgs; [
    # Remote Access
    rustdesk-flutter

    # Browser Related
    persepolis
    xclicker
    (vivaldi.overrideAttrs
      (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
      }))
    vivaldi-ffmpeg-codecs

    # Entertainment
    vlc

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
    python313

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
