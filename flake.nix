{
  description = "Zach's Modular NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    chaotic,
    nix-flatpak,
    zen-browser,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      config.allowBroken = true;
      config.rocmsupport = true;
    };

    # Import the hosts configuration
    hosts = import ./hosts {
      inherit nixpkgs self;
    };
  in {
    # Use the hosts configuration to define nixosConfigurations
    nixosConfigurations = hosts;
  };
}
