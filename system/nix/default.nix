{pkgs, ...}: {
  # Adding automatic nix flake updates:
  system.autoUpgrade = {
    enable = true;
    flake = "github:tkmockingbird/nix-config";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    dates = "06:15";
    persistent = true;
  };

  nix = {
    # Enable lix
    package = pkgs.lix;

    # Automated Garbage Collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-old-than 3d";
    };

    settings = {
      auto-optimise-store = true;
      # Uses binary Cache - Saves download time
      builders-use-substitutes = true;
      # allow sudo users to mark the following values as trusted
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      accept-flake-config = true;
      keep-derivations = true;
      keep-outputs = true;
      warn-dirty = false;
      max-jobs = "auto";
      # continue building derivations if one fails
      keep-going = true;
      log-lines = 20;
      # Enables Flakes and other experimental commands
      extra-experimental-features = ["flakes" "nix-command" "recursive-nix" "ca-derivations"];
      # Isolates packages from eachother. Necessary for Bottles
      sandbox = true;
      # Uses binary Cache - Saves download time
      substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
  # Allow Broken and Unfree Nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
  services.fwupd.enable = true;
}
