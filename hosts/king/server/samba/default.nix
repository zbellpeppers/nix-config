{ ... }:
{
  services.samba = {
    enable = true;
    openFirewall = true;
    securityType = "user";
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "smbnix";
        "netbios name" = "smbnix";
        "security" = "user";
        "hosts allow" = "100.64.0.0/10";
        "hosts deny" = "0.0.0.0/0";
        "map to guest" = "bad user";
      };
      "public" = {
        "path" = "/home/zachary/Desktop/samba_share";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "create mask" = "0660";
        "directory mask" = "0755";
        "force user" = "zachary";
        "force group" = "zachary";
      };
    };
  };
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  networking.firewall.allowPing = true;
}
