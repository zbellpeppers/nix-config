{
  pkgs,
  config,
  inputs,
  ...
}: {
  programs = {
    fish.enable = true;
    zsh.enable = true;
    kdeconnect.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      # Adds proton-ge-custom to steam compatability
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
      };
    };

    # Enable gamescope
    gamescope = {
      enable = true;
      capSysNice = false;
    };

    # Enable gamemode
    gamemode.enable = true;

    # GPG
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
