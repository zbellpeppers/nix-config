{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./packages
    #./gnome
  ];
}
