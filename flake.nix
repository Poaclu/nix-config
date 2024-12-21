{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
    };
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
          ./hosts/dragonfly/hardware-configuration.nix
          ./desktop.nix
          ./system-config.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      #killi = nixpkgs.lib.nixosSystem {
      #  specialArgs = {inherit inputs;};
      #  modules = [
      #    disko.nixosModules.disko
      #    inputs.home-manager.nixosModules.default
      #    ./disko-config.nix
      #    ./configuration.nix
      #  ];
      #};
    };
  };
}
