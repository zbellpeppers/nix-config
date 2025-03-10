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

  # You can add more host-specific settings
  system.stateVersion = "25.05";
}
