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
  # Define hosts below
  # King host
  king = mkHost {
    name = "king";
    username = "zachary";
    modules = [
      # ../desktop-envs/plasma
      inputs.nixos-cosmic.nixosModules.default
      ../desktop-envs/cosmic
    ];
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
