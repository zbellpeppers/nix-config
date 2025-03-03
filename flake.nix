{
  description = "NixOS + Home Manager Configuration";

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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    chaotic,
    zen-browser,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    nixpkgsConfig = {
      allowUnfree = true;
      allowBroken = true;
      overlays = [
      ];
    };
  in {
    nixosConfigurations.king = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./user
        ./plasma
        ./system
        {nixpkgs.config = nixpkgsConfig;}
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zachary = import ./home-manager;
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
