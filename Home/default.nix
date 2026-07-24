{
self,
lib,
...
}:
let
  system = "x86_64-linux";
  pkgs = import self.inputs.nixpkgs {
    inherit system;
  };
in
{
  flake = {
    homeConfigurations = {
      poaclu = self.inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
        modules = [
          ./shell
          ./main.nix
          ./user.nix
          ../common
          self.inputs.nvf.homeManagerModules.default
        ];
      };
    };
  };
  perSystem = { system, config, ... }:
  let
    relevantHomeConfigs = lib.filterAttrs
      (_: hmCfg: hmCfg.activationPackage.system or null == system)
      self.homeConfigurations;
  in {
    checks = lib.mapAttrs'
      (name: hmCfg: lib.nameValuePair "homeConfig-${name}" hmCfg.activationPackage)
      relevantHomeConfigs;
  };
}
