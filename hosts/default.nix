{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;

  mkHost = name: system:
    nixpkgs.lib.nixosSystem {
      modules = [
        ({
          config,
          pkgs,
          ...
        }: {
          networking.hostName = name;
          nixpkgs.hostPlatform = system;
        })
        (./. + "/${name}")
      ];

      specialArgs = {
        inherit inputs;
        flake = self;
      };
    };
in {
  king = mkHost "king" "x86_64-linux";
  queen = mkHost "queen" "x86_64-linux";
}
