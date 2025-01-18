{
  description = "Zach's Modular NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    chaotic,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      config.allowBroken = true;
    };
  in {
    nixosConfigurations.zach-nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./system
        ./desktop
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.zachary = import ./home-manager;
          home-manager.backupFileExtension = "backup";
        }
        chaotic.nixosModules.default
      ];
    };
  };
}
