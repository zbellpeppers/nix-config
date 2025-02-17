{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./git
    ./desktop-entries
  ];

  home.packages = with pkgs; [
    joplin-desktop
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
