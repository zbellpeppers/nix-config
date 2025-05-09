{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  inherit (inputs.nix-minecraft.lib) collectFilesAt;
  modpack = pkgs.fetchPackwizModpack {
    url = "https://github.com/zbellpeppers/packwiz/raw/refs/heads/main/pack.toml";
    packHash = "sha256-26Daud5cZIiPaxyCgLaG3fnZz6ItGhumKMKxe69n6xY=";
  };
in {
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
      autoStart = false;
      symlinks = {
        "mods" = "${modpack}/mods";
      };
      files = collectFilesAt modpack "config";
      jvmOpts = "-Xms512M -Xmx8192M";
      # Specify the custom minecraft server package
      package = pkgs.fabricServers.fabric-1_21_1;

      serverProperties = {
        accepts-transfers = false;
        allow-flight = true;
        allow-nether = true;
        broadcast-console-to-ops = true;
        broadcast-rcon-to-ops = true;
        difficulty = "normal";
        enable-command-block = false;
        enable-jmx-monitoring = false;
        enable-query = false;
        enable-rcon = false;
        enable-status = true;
        enforce-secure-profile = true;
        enforce-whitelist = false;
        entity-broadcast-range-percentage = 100;
        force-gamemode = false;
        function-permission-level = 2;
        gamemode = "survival";
        generate-structures = true;
        hardcore = false;
        hide-online-players = false;
        initial-disabled-packs = "";
        initial-enabled-packs = "vanilla";
        level-name = "sarah_zach_forever";
        level-seed = 8696454726808067462;
        level-type = "minecraft\:betterx";
        log-ips = true;
        max-chained-neighbor-updates = 1000000;
        max-players = 4;
        max-tick-time = 60000;
        max-world-size = 29999984;
        motd = "Our Minecraft Server";
        network-compression-threshold = 256;
        online-mode = true;
        op-permission-level = 4;
        player-idle-timeout = 0;
        prevent-proxy-connections = false;
        pvp = true;
        rate-limit = 0;
        region-file-compression = "deflate";
        require-resource-pack = false;
        server-port = 25565;
        simulation-distance = 12;
        spawn-animals = true;
        spawn-monsters = true;
        spawn-npcs = true;
        spawn-protection = 16;
        sync-chunk-writes = true;
        use-native-transport = true;
        view-distance = 12;
      };
    };
  };
}
