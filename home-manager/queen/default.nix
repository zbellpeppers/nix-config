{ pkgs, ... }:
{
  imports = [
    ../common
    ./git
    # ./desktop-entries
  ];

  # Home packages specific to sarah
  home.packages = with pkgs; [
    kdePackages.spectacle
  ];

  home.username = "sarah";
  home.homeDirectory = "/home/sarah";
  home.stateVersion = "25.11";
}
