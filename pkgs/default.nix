{
  lib,
  self,
  inputs,
  ...
}:
{
  flake.overlays = {
    steelseriesgg-rs = final: prev: {
      steelseriesgg-rs = prev.callPackage ./steelseriesgg-rs.nix {};
    };
  };
  flake.nixosModules.steelseriesgg-rs = import ./steelseriesgg-rs-module.nix;
  perSystem = { pkgs, ... }: {
    packages.steelseriesgg-rs = pkgs.callPackage ./steelseriesgg-rs.nix {};
  };
}
