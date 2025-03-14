{
  description = "NixOS + Home Manager Configuration";

  inputs = {
    # Use nixpkgs provided by nixos-cosmic
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    nixpkgs.follows = "nixos-cosmic/nixpkgs";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    agenix.url = "github:ryantm/agenix";

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
    agenix,
    zen-browser,
    nixos-cosmic,
    ...
  } @ inputs: {
    nixosConfigurations = import ./hosts {
      inherit nixpkgs self;
    };
  };
}
