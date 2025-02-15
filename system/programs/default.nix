{
  pkgs,
  config,
  inputs,
  ...
}: {
  # TEMP TESTING STEAM GAMESCOPE FIX
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      gamescopeSession = {
        enable = true;
      };
    };
    zsh = {
      enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = false;
    };
  };
}
