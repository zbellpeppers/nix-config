{pkgs, ...}: {
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
      # use binary cache, its not gentoo
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
      extra-experimental-features = ["flakes" "nix-command" "recursive-nix" "ca-derivations"];

      # use binary cache, its not gentoo
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
