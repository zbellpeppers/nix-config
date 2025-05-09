{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];
  # Minecraft server - General
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      enable = true;

      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_1;

      symlinks = {
        "mods" = "/home/zachary/nix-config/hosts/king/server/minecraft/packwiz/mods";
      };
    };
  };
}
