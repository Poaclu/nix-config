{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      lanzaboote,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        killi = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            lanzaboote.nixosModules.lanzaboote
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
            lanzaboote.nixosModules.lanzaboote
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
