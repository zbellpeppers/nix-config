{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./bash
    ./git
    ./tealdeer
    ./vscode
    ./kitty-terminal
  ];

  home.file.".config/onlyoffice/DesktopEditors.conf".text = ''
    [fonts]
    font-text-name=Roboto
    font-text-size=11
    font-heading-name=Roboto
    font-heading-size=14
    font-spreadsheet-name=Roboto
    font-spreadsheet-size=12
  '';

  home.packages = with pkgs; [
    # CLI Tools
    wget
    pciutils
    p7zip
    fastfetch
    ddcutil

    # Browser Related
    persepolis
    firedragon

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

    # Office Suite
    libreoffice-qt-fresh
    hunspell
    hunspellDicts.en-us
    kdePackages.skanpage
    onlyoffice-desktopeditors

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
    fira-code
  ];
}
