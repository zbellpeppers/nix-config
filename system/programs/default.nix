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
      # Adds proton-ge-custom to steam compatability
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
      };
    };

    # Starship presets
    starship.presets = [
      "nerd-font-symbols"
    ];

    # Enable gamescope
    gamescope = {
      enable = true;
      capSysNice = false;
    };

    # Enable gamemode
    gamemode.enable = true;
  };
}
