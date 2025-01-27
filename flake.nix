{
  description = "Zach's Modular NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      config.allowBroken = true;
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
