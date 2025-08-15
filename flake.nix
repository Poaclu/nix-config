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
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      lanzaboote,
      hyprland,
      zen-browser,
      home-manager,
      ...
    }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      # helper for pure HM targets
    in {
      nixosConfigurations = {
        killi = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./hosts/killi/configuration.nix
            (import ./modules {
              inherit inputs;
              pkgs = pkgs;
              lib = pkgs.lib;
            })
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.poaclu = { ... }: {
              imports = [
                ./home/modules/shell
                ./home/modules/desktop
                ./home/modules/main.nix
                ./home/modules/user.nix
                zen-browser.homeModules.default
              ];
              _module.args.inputs = inputs;
              };
            }
          ];
        };
        kermel = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            ./hosts/kermel/configuration.nix
            (import ./modules {
              inherit inputs;
              pkgs = pkgs;
              lib = pkgs.lib;
            })
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.poaclu = { ... }: {
              imports = [
                ./home/modules/shell
                ./home/modules/desktop
                ./home/modules/main.nix
                ./home/modules/user.nix
                zen-browser.homeModules.default
              ];
              _module.args.inputs = inputs;
              };
            }
          ];
        };
      };
      homeConfigurations = {
        poaclu = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home/modules/shell
            ./home/modules/main.nix
            ./home/modules/user.nix
            ./home/modules/nix.nix
          ];
        };
      };
    };
}
