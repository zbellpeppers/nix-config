{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages
    ./git
    ./desktop-entries
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    obsidian
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
