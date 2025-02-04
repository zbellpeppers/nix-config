{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../common];
  home.username = "sarah";
  home.homeDirectory = "/home/sarah";
  home.stateVersion = "24.11";
}
