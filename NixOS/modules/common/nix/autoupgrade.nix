{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  cN = config.poaclu.customNix;
in
{
  options.poaclu = {
    customNix = {
      enable = lib.mkOption {
        description = "Enable Nix automatic gestion";
        type = lib.types.bool;
        default = true;
        example = false;
      };
      upgrade = lib.mkOption {
        default = false;
        type = lib.types.bool;
        description = "Enable Nix auto upgrade";
      };
    };
  };
  config = lib.mkIf cN.enable {
    system = {
      autoUpgrade = lib.mkIf cN.upgrade {
        enable = true;
        dates = "daily";
        operation = "boot";
        flake = inputs.self.outPath;
        flags = [
          "--flake /etc/nixos"
          "--update-input"
          "nixpkgs"
          "-L" # print build logs
        ];
        allowReboot = true;
        rebootWindow = {
          lower = "01:00";
          upper = "05:00";
        };
      };
    };
  };
}
