{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../common
    ./git
    ./desktop-entries
  ];

  home.packages = with pkgs; [
    joplin-desktop
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
