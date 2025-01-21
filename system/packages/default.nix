{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vivaldi
    sddm-sugar-dark
  ];
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    zsh = {
      enable = true;
    };
  };
}
