#{
#  imports = [
#    ./shell
#    ./desktop
#    ./main.nix
#    ./user.nix
#  ];
#}


{
self,
...
}:
{
  flake = {
    homeConfigurations = {
      poaclu = self.inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./shell
          ./main.nix
          ./user.nix
          ../Common
          self.inputs.nvf.homeManagerModules.default
        ];
      };
    };
  };
}
