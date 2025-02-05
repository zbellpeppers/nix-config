{
  config,
  lib,
  pkgs,
  ...
}: let
  vivaldi =
    pkgs.vivaldi.overrideAttrs
    (oldAttrs: {
      dontWrapQtApps = false;
      dontPatchELF = true;
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
    });
in {
  imports = [
    ../common
    ./git
    ./desktop-entries
  ];

  home.packages = with pkgs; [
    vivaldi
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
