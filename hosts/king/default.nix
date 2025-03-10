{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./user
  ];
  # Host-specific configuration goes here
  networking.hostName = "king";

  # Do not change without consulting documenntation - This is the nixos version at install
  system.stateVersion = "24.11";
}
