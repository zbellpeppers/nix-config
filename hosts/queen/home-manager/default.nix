{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages
    /plasma
    ./zshell
    #./gnome
  ];
  home.username = "sarah";
  home.homeDirectory = "/home/sarah";
  home.stateVersion = "24.11";
}
