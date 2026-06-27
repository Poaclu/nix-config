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
  flake.nixosModules = {
    steelseriesgg-rs = import ./steelseriesgg-rs-module.nix;
    iriun = import ./iriun-module.nix;
  };
  perSystem = { pkgs, system, ... }: {
    packages = {
      steelseriesgg-rs = pkgs.callPackage ./steelseriesgg-rs.nix {};
    } // lib.optionalAttrs (system == "x86_64-linux") {
      iriun = pkgs.callPackage ./iriun.nix {};
    };
  };
}
