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
        dragonfly = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/dragonfly/configuration.nix
            ./modules
          ];
        };
        killi = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            ./hosts/killi/configuration.nix
            ./modules
          ];
        };
      };
    };
}
