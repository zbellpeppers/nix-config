{
  config,
  pkgs,
  inputs,
  ...
}:
let
  # appflowy = pkgs.callPackage ../../../../modules/appflowy {};
in
{
  imports = [
    ./bash
    ./config
    ./fish
    ./micro
    ./tealdeer
    ./vscode
    ./zsh
  ];
  home.packages = with pkgs; [
    # Remote Access
    rustdesk-flutter

    # Gaming
    prismlauncher
    ferium
    obs-studio

    # Browser Related
    persepolis
    xclicker

    # Entertainment
    vlc

    #Communication
    vesktop

    # Office Apps
    kdePackages.skanpage
    protonmail-desktop

    # Spell Checks and Dictionaries
    aspell
    aspellDicts.en
    hunspell
    hunspellDicts.en-us

    # Programming
    gcc
    kdePackages.kate
    python313
    python313Packages.pip
    python313Packages.pipx

    # General Apps
    speedcrunch

    # Torrenting
    calibre
    qbittorrent-enhanced
  ];
}
