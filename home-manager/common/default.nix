{
  pkgs,
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
  home.enableNixpkgsReleaseCheck = true;
  home.packages = with pkgs; [
    # Remote Access
    rustdesk-flutter

    # Gaming
    prismlauncher
    ferium
    mangohud
    wineWowPackages.waylandFull
    winetricks
    protontricks
    mono
    lutris

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
    protonvpn-gui

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
    fsearch
    via

    # Torrenting
    calibre
    qbittorrent-enhanced
  ];
}
