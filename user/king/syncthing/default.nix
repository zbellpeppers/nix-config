{...}: {
  services.syncthing = {
    enable = true;
    group = "bpfsync";
    user = "zachary";
    dataDir = "/home/zachary/Syncthing";
    configDir = "/home/zachary/Syncthing/.config/syncthing";
    # overrideDevices = true; # overrides any devices added or deleted through the WebUI
    # overrideFolders = true; # overrides any folders added or deleted through the WebUI
    settings = {
      devices = {
        "zach-nixos" = {id = "DEVICE-ID-GOES-HERE";};
        "zach-windows11" = {id = "DEVICE-ID-GOES-HERE";};
        "device3" = {id = "DEVICE-ID-GOES-HERE";};
        "device4" = {id = "DEVICE-ID-GOES-HERE";};
      };
      folders = {
        "All - Testing" = {
          # Name of folder in Syncthing, also the folder ID
          path = "/home/zachary/Desktop/All"; # Which folder to add to Syncthing
          devices = ["zach-nixos" "zach-windows11"]; # Which devices to share the folder with
          # ignorePerms = false; # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
        };
      };
    };
  };
}
