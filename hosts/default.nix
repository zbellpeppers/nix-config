{
  nixpkgs,
  self,
  nixpkgs-ferium,
  ...
}: let
  inherit (self) inputs;

  feriumOverlay = final: prev: {
    ferium = nixpkgs-ferium.legacyPackages.${prev.system}.ferium;
  };

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
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      feriumOverlay
    ];
  };

  # Queen host
  queen = mkHost {
    hostname = "queen";
    username = "sarah";
    desktop = "pantheon";
    modules = [
    ];
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
    ];
  };
}
