{
  description = "NixOS + Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    agenix.url = "github:ryantm/agenix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-flatpak,
    agenix,
    nix-vscode-extensions,
    ...
  } @ inputs: {
    nixosConfigurations = import ./hosts {
      inherit nixpkgs self;
    };
  };
}
