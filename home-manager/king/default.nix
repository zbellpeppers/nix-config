{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../common
    ./git
    ./desktop-entries
    ./plasma-manager
  ];

  home.packages = with pkgs; [
    obsidian
    inputs.zen-browser.packages."x86_64-linux".default
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "25.05";
}
