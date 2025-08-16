{
  description = "Nixos config flake";

  inputs = {
    ## NixOS Native
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## App specific iputs
    hyprland.url = "github:hyprwm/Hyprland";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## Extensions
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    play = {
      url = "github:TophC7/play.nix";
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
      home-manager,
      nur,
      ...
    }@inputs:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs { 
        inherit system;
        overlays = [ nur.overlays.default ];
      };
      # helper for pure HM targets
    in {
      nixosConfigurations = {
        killi = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            lanzaboote.nixosModules.lanzaboote
            nur.modules.nixos.default
            nur.legacyPackages."${system}".repos.iopq.modules.xraya
            ./hosts/killi/configuration.nix
            (import ./modules {
              inherit inputs;
              pkgs = pkgs;
              lib = pkgs.lib;
            })
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.poaclu = { ... }: {
              imports = [
                ./home/modules/shell
                ./home/modules/desktop
                ./home/modules/main.nix
                ./home/modules/user.nix
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
            nur.modules.nixos.default
            nur.legacyPackages."${system}".repos.iopq.modules.xraya
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
