{ pkgs, ... }:
{
  services.postgresql = {
    enable = true;
    initialScript = pkgs.writeText "traccar-init" ''
      CREATE ROLE traccar WITH LOGIN PASSWORD '$(cat /run/secrets/traccar-db-password)';
      CREATE DATABASE traccar WITH OWNER traccar;
    '';
  };
}
