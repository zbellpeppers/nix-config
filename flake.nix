{
  description = "Zach's Simplified NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    chaotic,
    zen-browser,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowBroken = true;
      };
      overlays = [
        inputs.nix-vscode-extensions.overlays.default
      ];
    };
  in {
    nixosConfigurations.king = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./hosts/king
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zachary = import ./home-manager/king;
          home-manager.extraSpecialArgs = {
            inherit inputs;
            flake = self;
          };
        }
        nix-flatpak.nixosModules.nix-flatpak
        chaotic.nixosModules.default
      ];
      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
  };
}
