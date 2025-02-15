{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
  };
}
