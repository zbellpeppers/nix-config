{ ... }:
{
  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "file_server";
        "netbios name" = "sambanix";
        "security" = "user";
        "hosts allow" = "100.64.0.0/10 localhost 127.0.0.1";
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
    openFirewall = true;
  };
  networking.firewall.allowPing = true;
}
