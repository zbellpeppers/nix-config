{
  description = "Zach's Modular NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    chaotic,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      config.allowBroken = true;
    };

    # Import the hosts configuration
    hosts = import ./hosts {
      inherit nixpkgs self;
      inherit nix-vscode-extensions;
    };
  in {
    # Use the hosts configuration to define nixosConfigurations
    nixosConfigurations = hosts;
  };
}
