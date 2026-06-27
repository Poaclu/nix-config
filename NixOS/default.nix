{
  lib,
  self,
  ...
}:
let
  entries = builtins.attrNames (builtins.readDir ./hosts/.);
  configs = builtins.filter (dir: builtins.pathExists (./hosts/. + "/${dir}/configuration.nix")) entries;
  homeManagerCfg = name: userPackages: extraImports: {
    home-manager.useGlobalPkgs = false;
    home-manager.useUserPackages = userPackages;
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
    ]
    ++ (if builtins.pathExists (./hosts/. + "/${name}/home.nix")
        then [ (./hosts/. + "/${name}/home.nix") ]
        else [])
    ++ extraImports;
  };
in
{
  flake.nixosConfigurations = 
      let
        nixpkgsMap = {
        #killi = "-unstable";
        };
        systemArchMap = {
          odonata = "aarch64-linux";
        };
        myNixosSystem =
          name: self.inputs."nixpkgs${lib.attrsets.attrByPath [ name ] "" nixpkgsMap}".lib.nixosSystem;

        mobileDeviceMap = {
          odonata = [
            (
              import (self.inputs.mobile-nixos + "/lib/configuration.nix") {
                device = "oneplus-enchilada"; 
              }
            )
          ];
        };
        extraModulesFor = 
          name: lib.attrsets.attrByPath [ name ] [ ] mobileDeviceMap;
      in
      lib.listToAttrs (
        builtins.map (
          name:
          lib.nameValuePair name (
            (myNixosSystem name) {
              system = lib.attrsets.attrByPath [ name ] "x86_64-linux" systemArchMap;
              specialArgs = {
                inherit self;
              };
              
              modules = [
                ./modules/common
                ./modules/desktop
                ../common
                self.inputs.agenix.nixosModules.default
                self.inputs.lanzaboote.nixosModules.lanzaboote
                self.inputs.disko.nixosModules.disko
                self.nixosModules.steelseriesgg-rs
                self.inputs."home-manager${
                  lib.attrsets.attrByPath [ name ] "" nixpkgsMap
                }".nixosModules.home-manager
                (./hosts/. + "/${name}/configuration.nix")
                (homeManagerCfg name false [ ])
              ]
              ++ extraModulesFor name;
            }
          )
        ) configs
      );
}
