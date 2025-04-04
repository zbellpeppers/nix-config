{pkgs, ...}: {
  nix = {
    # Enable lix
    package = pkgs.lix;

    # Prevent automated garbage collector
    gc.automatic = false;

    settings = {
      auto-optimise-store = true;

      # Uses binary Cache - Saves download time
      builders-use-substitutes = true;

      # allow sudo users to mark the following values as trusted
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      accept-flake-config = true;

      # Prevents certain build items from being removed via nix-collect-garbage
      keep-derivations = true;
      keep-outputs = true;

      # Stops the constant git warnings
      warn-dirty = false;
      max-jobs = "auto";

      # Continue building derivations if something fails
      keep-going = true;
      log-lines = 20;

      # Enables Flakes and other experimental commands
      extra-experimental-features = ["flakes" "nix-command"];

      # Automatic usage of --show-trace when a build error occurs
      show-trace = true;

      # Uses binary Cache - Saves download time
      substituters = [
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
  };
}
