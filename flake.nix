{
  description = "NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    nixpkgs-ferium = {
      url = "github:NixOS/nixpkgs/dc346fdf12f190192e80a6e6f57b185d510ccfb2";
    };
    ragenix = {
      url = "github:/yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
      nix-vscode-extensions,
      plasma-manager,
      nixpkgs-ferium,
      ragenix,
      ...
    }@inputs:
    {
      nixosConfigurations = import ./hosts {
        inherit nixpkgs nixpkgs-ferium self;
      };
    };
}
