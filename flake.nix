{
  description = "Nixos config flake";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org/"
      "https://cachix.cachix.org"
      "https://hyprland.cachix.org"
      "https://nixpkgs.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    ## NixOS Native
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/Home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## App specific iputs
    hyprland = {
      url = "github:hyprwm/Hyprland";
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ## Extensions
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    play = {
      url = "github:TophC7/play.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        chaotic.follows = "chaotic";
        home-manager.follows = "home-manager";
      };
    };
    mobile-nixos = {
      url = "github:mobile-nixos/mobile-nixos";
      flake = false; # We import it directly, not as a flake
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
      mobile-nixos,
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
            ./NixOS/common
            ./NixOS/desktop
            ./Common
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.backupFileExtension = "bak";
              home-manager.users.poaclu = { ... }: {
              imports = [
                inputs.zen-browser.homeModules.beta
                inputs.nvf.homeManagerModules.default
                ./Home/shell
                ./Home/desktop
                ./Home/main.nix
                ./Home/user.nix
                ./Common
                ./hosts/killi/home.nix
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
            ./NixOS/common
            ./NixOS/desktop
            ./Common
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.poaclu = { ... }: {
              imports = [
                inputs.zen-browser.homeModules.beta
                inputs.nvf.homeManagerModules.default
                ./Home/shell
                ./Home/desktop
                ./Home/main.nix
                ./Home/user.nix
                ./Common
              ];
              _module.args.inputs = inputs;
              };
            }
          ];
        };
        odonata = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs nixpkgs; };
          modules = [
            (import "${mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
            lanzaboote.nixosModules.lanzaboote
            nur.modules.nixos.default
            nur.legacyPackages."${system}".repos.iopq.modules.xraya
            ./hosts/odonata/configuration.nix
            ./NixOS/common
            ./NixOS/desktop
            ./Common
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.users.poaclu = { ... }: {
              imports = [
                inputs.zen-browser.homeModules.beta
                inputs.nvf.homeManagerModules.default
                ./Home/shell
                ./Home/desktop
                ./Home/main.nix
                ./Home/user.nix
                ./Common
                ./hosts/odonata/home.nix
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
          ./Home/shell
          ./Home/main.nix
          ./Home/user.nix
          ./Common
          inputs.nvf.homeManagerModules.default
        ];
      };
    };
  };
}
