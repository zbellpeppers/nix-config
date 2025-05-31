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
    inputs.zen-browser.packages."${system}".default
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "25.11";
}
