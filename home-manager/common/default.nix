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
    ./config
    ./micro
    ./tealdeer
    ./vscode
    ./zsh
  ];
  home.packages = with pkgs; [
    # Remote Access
    # rustdesk-flutter

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
    protonmail-desktop

    # Spell Checks and Dictionaries
    aspell
    aspellDicts.en
    hunspell
    hunspellDicts.en-us

    # Programming
    alejandra
    gcc
    kdePackages.kate
    python313

    # General Apps
    speedcrunch

    # Torrenting
    calibre
    qbittorrent-enhanced
  ];
}
