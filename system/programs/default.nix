{
  pkgs,
  ...
}:
{
  programs = {
    zoxide.enable = true;
    fish.enable = true;
    zsh.enable = true;
    kdeconnect.enable = true;
    xwayland.enable = true;
    obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs; [
        obs-studio-plugins.obs-pipewire-audio-capture
      ];
    };

    java = {
      enable = true;
      package = pkgs.graalvmPackages.graalvm-ce;
    };

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
      capSysNice = true;
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
