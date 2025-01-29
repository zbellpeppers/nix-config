{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages
    ./plasma
    ./zshell
    #./gnome
  ];
  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
