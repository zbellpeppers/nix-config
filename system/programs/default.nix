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
      gamescopeSession = {
        enable = true;
        args = [
          "-w 1920 -h 1080"
          "--borderless"
          "--adaptive-sync"
          "--fullscreen"
          "--mangoapp"
        ];
      };
    };
    zsh = {
      enable = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
