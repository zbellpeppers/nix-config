{
  pkgs,
  config,
  ...
}: {
  imports = [
  ];

  services = {
    # Enables fwupd - CLI-based Firmware Updater
    fwupd.enable = true;

    # Openrgb
    hardware.openrgb.enable = true;

    # Enable flatpak managment
    flatpak = {
      enable = true;
      update.onActivation = true;
      packages = [
        "com.stremio.Stremio"
        "org.onlyoffice.desktopeditors"
      ];
    };

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
  };
}
