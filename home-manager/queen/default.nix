{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../common];

  home.packages = with pkgs; [
    chromium
  ];
  home.username = "sarah";
  home.homeDirectory = "/home/sarah";
  home.stateVersion = "24.11";
}
