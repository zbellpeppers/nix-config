{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./git
    ./plasma-manager
  ];

  home.packages = with pkgs; [
    chromium
  ];
  home.username = "sarah";
  home.homeDirectory = "/home/sarah";
  home.stateVersion = "24.11";
}
