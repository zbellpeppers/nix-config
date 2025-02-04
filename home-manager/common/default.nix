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
}
