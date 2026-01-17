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
}
