{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: {
    nixosConfigurations = {
      dragonfly = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/dragonfly/configuration.nix
          ./desktop.nix
          ./system-config.nix
        ];
      };
      killi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/killi/configuration.nix
          ./desktop.nix
          ./system-config.nix
	  ./gaming.nix
	  ./security.nix
        ];
      };
    };
  };
}
