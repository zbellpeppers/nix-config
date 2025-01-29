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
  ];
  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
