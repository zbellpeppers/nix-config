{
  pkgs,
  config,
  ...
}: {
  imports = [
  ];

  services = {
    # Openrgb
    hardware.openrgb.enable = true;
    # Openssh configuration
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
    tailscale = {
      enable = true;
      port = 0;
      openFirewall = true;
      useRoutingFeatures = "both";
    };
  };
}
