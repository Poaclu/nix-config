{
  self,
  ...
  }:
  {
  flake = {
    nixosConfigurations = {
      killi = self.inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self;
        };
        modules = [
          ./hosts/killi/configuration.nix
          ({ pkgs, ... }: {
            imports = [
              ./modules/common
              ./modules/desktop
              ../common
              self.inputs.agenix.nixosModules.default
              self.inputs.play.nixosModules.play
              self.inputs.lanzaboote.nixosModules.lanzaboote
              self.inputs.disko.nixosModules.disko
              self.inputs.home-manager.nixosModules.home-manager {
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "bak";
                home-manager.extraSpecialArgs = {
                  inherit (self) inputs;
                };
                home-manager.users.poaclu.imports = [
                  self.inputs.zen-browser.homeModules.beta
                  self.inputs.nvf.homeManagerModules.default
                  ../Home/shell
                  ../Home/desktop
                  ../Home/main.nix
                  ../Home/user.nix
                  ../common
                  ./hosts/killi/home.nix
                ];
              }
            ];
          })
        ];
      };
      kermel = self.inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self;
        };
        modules = [
          ./hosts/kermel/configuration.nix
          ({ pkgs, ... }: {
            imports = [
              ./modules/common
              ./modules/desktop
              ../common
              self.inputs.agenix.nixosModules.default
              self.inputs.play.nixosModules.play
              self.inputs.lanzaboote.nixosModules.lanzaboote
              self.inputs.disko.nixosModules.disko
              self.inputs.home-manager.nixosModules.home-manager {
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "bak";
                home-manager.extraSpecialArgs = {
                  inherit (self) inputs;
                };
                home-manager.users.poaclu.imports = [
                  self.inputs.zen-browser.homeModules.beta
                  self.inputs.nvf.homeManagerModules.default
                  ../Home/shell
                  ../Home/desktop
                  ../Home/main.nix
                  ../Home/user.nix
                  ../common
                ];
              }
            ];
          })
        ];
      };
      odonata = self.inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self;
        };
        modules = [
          ./hosts/odonata/configuration.nix
          ({ pkgs, ... }: {
            imports = [
              (import "${self.inputs.mobile-nixos}/lib/configuration.nix" { device = "oneplus-enchilada"; })
              ./modules/common
              ./modules/desktop
              ../common
              self.inputs.agenix.nixosModules.default
              self.inputs.play.nixosModules.play
              self.inputs.lanzaboote.nixosModules.lanzaboote
              self.inputs.disko.nixosModules.disko
              self.inputs.home-manager.nixosModules.home-manager {
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "bak";
                home-manager.extraSpecialArgs = {
                  inherit (self) inputs;
                };
                home-manager.users.poaclu.imports = [
                  self.inputs.zen-browser.homeModules.beta
                  self.inputs.nvf.homeManagerModules.default
                  ../Home/shell
                  ../Home/desktop
                  ../Home/main.nix
                  ../Home/user.nix
                  ../common
                  ./hosts/odonata/home.nix
                ];
              }
            ];
          })
        ];
      };
      coruscant = self.inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self;
        };
        modules = [
          ./hosts/coruscant/configuration.nix
          ({ pkgs, ... }: {
            imports = [
              ./modules/common
              ./modules/desktop
              ../common
              self.inputs.agenix.nixosModules.default
              self.inputs.play.nixosModules.play
              self.inputs.lanzaboote.nixosModules.lanzaboote
              self.inputs.disko.nixosModules.disko
              self.inputs.home-manager.nixosModules.home-manager {
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "bak";
                home-manager.extraSpecialArgs = {
                  inherit (self) inputs;
                };
                home-manager.users.poaclu.imports = [
                  self.inputs.zen-browser.homeModules.beta
                  self.inputs.nvf.homeManagerModules.default
                  ../Home/shell
                  ../Home/desktop
                  ../Home/main.nix
                  ../Home/user.nix
                  ../common
                  ./hosts/coruscant/home.nix
                ];
              }
            ];
          })
        ];
      };
      #homeConfigurations = {
      #  poaclu = inputs.home-manager.lib.homeManagerConfiguration {
      #    modules = [
      #     ../Home/shell
      #     ../Home/main.nix
      #     ../Home/user.nix
      #     ../common
      #     inputs.nvf.homeManagerModules.default
      #   ];
      # };
      #};
    };
  };
}
