{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        killi = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            ./hosts/killi/configuration.nix
            (import ./modules {
              inherit inputs;
              pkgs = nixpkgs;
              lib = nixpkgs.lib;
            })
          ];
        };
        kermel = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            ./hosts/kermel/configuration.nix
            (import ./modules {
              inherit inputs;
              pkgs = nixpkgs;
              lib = nixpkgs.lib;
            })
          ];
        };
      };
    };
}
