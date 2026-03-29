# pkgs/steelseriesgg-rs-module.nix
{ config, lib, pkgs, ... }:

let
  steelseriesgg-rs = pkgs.callPackage ./steelseriesgg-rs.nix {};
  cfg = config.programs.steelseriesgg-rs;
in {
  options.programs.steelseriesgg-rs = {
    enable = lib.mkEnableOption "SteelSeries GG for Linux";
    user = lib.mkOption {
      type = lib.types.str;
      description = "User to add to the input group";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ steelseriesgg-rs ];
    services.udev.packages = [ steelseriesgg-rs ];
    users.users.${cfg.user}.extraGroups = [ "input" ];
  };
}
