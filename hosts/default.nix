{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;

  # Function to create a NixOS system configuration
  mkHost = {
    hostname,
    username,
    system ? "x86_64-linux",
    desktop ? "plasma",
    modules ? [],
    overlays ? [],
    extraHomeManagerConfig ? {},
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          # Host-specific configuration
          ./${hostname}
          ../desktop-envs/${desktop}

          # Common modules
          ../system

          # Nixpkgs configuration
          {
            nixpkgs = {
              config = {
                allowUnfree = true;
                allowBroken = true;
              };
              overlays = overlays;
            };
          }

          # Home Manager configuration
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ../home-manager/${hostname};
            home-manager.extraSpecialArgs =
              {
                inherit inputs;
                flake = self;
              }
              // extraHomeManagerConfig;
          }

          # Flatpak
          inputs.nix-flatpak.nixosModules.nix-flatpak

          # Sops-nix
          inputs.agenix.nixosModules.default
          {
            environment.systemPackages = [inputs.agenix.packages.${system}.default];
            age.identityPaths = [
              "/etc/ssh/ssh_host_ed25519_key"
              "/home/${username}/.ssh/id_ed25519"
            ];
          }
        ]
        ++ modules;

      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  # King host
  king = mkHost {
    hostname = "king";
    username = "zachary";
    desktop = "gnome";
    modules = [
    ];
    overlays = [
      (final: prev: {
        mutter = prev.mutter.overrideAttrs (oldAttrs: {
          # GNOME dynamic triple buffering (huge performance improvement)
          # See https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/1441
          # Also https://gitlab.gnome.org/vanvugt/mutter/-/tree/triple-buffering-v4-47
          src = final.fetchFromGitLab {
            domain = "gitlab.gnome.org";
            owner = "vanvugt";
            repo = "mutter";
            rev = "triple-buffering-v4-47";
            hash = "sha256-6n5HSbocU8QDwuhBvhRuvkUE4NflUiUKE0QQ5DJEzwI=";
          };

          # GNOME 47 requires the gvdb subproject which is not included in the triple-buffering branch
          # This copies the necessary gvdb files from the official GNOME repository
          preConfigure = let
            gvdb = final.fetchFromGitLab {
              domain = "gitlab.gnome.org";
              owner = "GNOME";
              repo = "gvdb";
              rev = "2b42fc75f09dbe1cd1057580b5782b08f2dcb400";
              hash = "sha256-CIdEwRbtxWCwgTb5HYHrixXi+G+qeE1APRaUeka3NWk=";
            };
          in ''
            cp -a "${gvdb}" ./subprojects/gvdb
          '';
        });
      })
    ];
  };

  # Queen host
  queen = mkHost {
    hostname = "queen";
    username = "sarah";
    desktop = "pantheon";
    modules = [
    ];
  };
}
