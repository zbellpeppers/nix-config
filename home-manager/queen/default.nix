{pkgs, ...}: {
  imports = [
    ../common
    ./git
    # ./desktop-entries
  ];

  # Home packages specific to sarah
  home.packages = with pkgs; [
    satty
  ];

  home.username = "sarah";
  home.homeDirectory = "/home/sarah";
  home.stateVersion = "25.05";
}
