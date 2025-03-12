{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;

  # Function to create a NixOS system configuration
  mkHost = {
    name,
    username,
    system ? "x86_64-linux",
    modules ? [],
    extraHomeManagerConfig ? {},
  }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          # Host-specific configuration
          ./${name}

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
            home-manager.users.${username} = import ../home-manager/${name};
            home-manager.extraSpecialArgs =
              {
                inherit inputs;
                flake = self;
              }
              // extraHomeManagerConfig;
          }

          # Chaotic nix repo
          inputs.chaotic.homeManagerModules.default

          # Flatpak
          inputs.nix-flatpak.nixosModules.nix-flatpak

          # Sops-nix
          inputs.sops-nix.nixosModules.sops
        ]
        ++ modules;

      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  # Define hosts below
  # King host
  king = mkHost {
    name = "king";
    username = "zachary";
    modules = [../desktop-envs/plasma];
  };

  # Queen host
  queen = mkHost {
    name = "queen";
    username = "sarah";
    modules = [../desktop-envs/pantheon];
  };
  # You can add more hosts like this:
  # other-host = mkHost {
  #   name = "other-host";
  #   system = "aarch64-linux";  # optional, defaults to x86_64-linux
  #   modules = [ ../some-other-module ];
  #   extraHomeManagerConfig = { /* additional config */ };
  # };
}
