{
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
    obsidian
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "25.05";
}
