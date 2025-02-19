{
  config,
  inputs,
  ...
}: {
  age.secrets.syncthing-zach.file = ../../../secrets/syncthing-zach.age;
  services.syncthing = {
    enable = true;
    group = "syncthing";
    user = "zachary";
    dataDir = "/home/zachary/Syncthing";
    configDir = "/home/zachary/Syncthing/.config/syncthing";
    overrideDevices = true; # overrides any devices added or deleted through the WebUI
    overrideFolders = true; # overrides any folders added or deleted through the WebUI
    settings = {
      gui = {
        user = "tkmockingbird";
        passwordFile = config.age.secrets.syncthing-zach.path;
      };
      devices = {
        "zach-nixos" = {id = "RMRMQEI-E5OGP2P-LKALUWX-BNOIK7N-5OWRCRO-7JX27LA-3GAKB6N-6EXUGAK";};
        "zach-windows11" = {id = "JPPW443-FVDAVQN-JVBRXR6-VOA3HHH-ACMWFDD-CPXMWFV-WQOUXMR-XVDVTQ4";};
        "device3" = {id = "DEVICE-ID-GOES-HERE";};
        "device4" = {id = "DEVICE-ID-GOES-HERE";};
      };
      folders = {
        "All" = {
          # Name of folder in Syncthing, also the folder ID
          path = "/home/zachary/Desktop/All"; # Which folder to add to Syncthing
          devices = ["zach-nixos" "zach-windows11"]; # Which devices to share the folder with
          # ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
        };
      };
    };
  };
}
