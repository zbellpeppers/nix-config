{ pkgs, ... }:
{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
    ensureUsers = [
      {
        name = "traccar";
        ensurePermissions = {
          "traccar.*" = "ALL PRIVILEGES";
        };
      }
    ];
    ensureDatabases = [ "traccar" ];
  };
}
