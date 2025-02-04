{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./git
  ];
  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
