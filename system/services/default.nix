{
  pkgs,
  ...
}:
{
  systemd.services = {
    systemd-udev-settle.enable = false; # May reduce booting time
  };

  services = {
    # Packages that require higher permissions access
    udev.packages = with pkgs; [
      via
    ];

    # OpenRGB control
    hardware.openrgb.enable = true;

    # Openssh configuration
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
