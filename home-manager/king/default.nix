{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../common
    ./git
    ./desktop-entries
  ];

  home.packages = with pkgs; [
    (pkgs.vivaldi.overrideAttrs
      (oldAttrs: {
        dontWrapQtApps = false;
        dontPatchELF = true;
        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
      }))
    vivaldi-ffmpeg-codecs
  ];

  home.username = "zachary";
  home.homeDirectory = "/home/zachary";
  home.stateVersion = "24.11";
}
