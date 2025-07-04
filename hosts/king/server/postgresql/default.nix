{ ... }:
{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "traccar" ];
    ensureUsers = [
      {
        name = "traccar";
        ensureDBOwnership = true;
      }
    ];
  };
}
