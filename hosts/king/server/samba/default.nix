{ pkgs, ... }:
{
  # This systemd service syncs changes made to documents to the samba server.
  systemd = {
    services.sync-family-documents = {
      description = "Sync Family Documents to the public Samba share";
      serviceConfig = {
        Type = "oneshot";
        User = "zachary";
      };
      # The command that performs the synchronization.
      script = ''
        ${pkgs.rsync}/bin/rsync -a --delete /home/zachary/Desktop/All/Documents/ /home/zachary/Desktop/samba_share/public/family_docs/
      '';
    };

    # Add this section to schedule the sync service.
    timers.sync-family-documents = {
      description = "Run the document sync job every 15 minutes";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*:0/15"; # Runs every 15 minutes of every hour.
        Persistent = true; # If the machine was off, run on the next boot.
      };
    };
  };
  networking.firewall = {
    allowPing = true;
  };
  services.samba = {
    enable = true;
    openFirewall = false;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "file_server";
        "netbios name" = "sambanix";
        "security" = "user";
        "hosts allow" = "100.64.0.2 100.64.0.3 100.64.0.5 100.64.0.7 127.0.0.1";
        "hosts deny" = "0.0.0.0/0";
        "map to guest" = "bad user";
      };
      public = {
        path = "/home/zachary/Desktop/samba_share";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "valid users" = "@sambashare"; # only members of the group
        "force user" = "zachary"; # files owned by Zachary
        "force group" = "sambashare"; # but writable by the group
        "create mask" = "0664";
        "directory mask" = "0775";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = false;
  };
}
