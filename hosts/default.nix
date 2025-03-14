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
            nixpkgs.config = {
              allowUnfree = true;
              allowBroken = true;
              overlays = [];
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
    desktop = "plasma";
    modules = [
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
