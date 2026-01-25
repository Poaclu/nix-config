{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  gc = config.poaclu.garbage;
in
{
  options.poaclu = {
    garbage.enable = lib.mkOption {
      default = true;
      type = lib.types.bool;
      description = "Enable Nix grabage colector";
    };
  };
  config.nix.gc = lib.mkIf gc.enable {
    automatic = true;
    dates = "weekly";
    persistent = true;
    options = "--delete-older-than 30d";
  };
}
