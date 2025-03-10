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
            home-manager.backupFileExtension = "0001";
            home-manager.users.${username} = import ../home-manager;
            home-manager.extraSpecialArgs =
              {
                inherit inputs;
                flake = self;
              }
              // extraHomeManagerConfig;
          }

          # Chaotic nix repo
          inputs.chaotic.homeManagerModules.default

          # Additional modules
          inputs.nix-flatpak.nixosModules.nix-flatpak
        ]
        ++ modules;

      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  # Define your hosts here
  king = mkHost {
    name = "king";
    username = "zachary";
    modules = [../desktop-envs/plasma];
  };

  # You can add more hosts like this:
  # other-host = mkHost {
  #   name = "other-host";
  #   system = "aarch64-linux";  # optional, defaults to x86_64-linux
  #   modules = [ ../some-other-module ];
  #   extraHomeManagerConfig = { /* additional config */ };
  # };
}
