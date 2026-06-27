{ config, lib, pkgs, ... }:

let
  iriun = pkgs.callPackage ./iriun.nix {};
  cfg = config.programs.iriun;
in {
  options.programs.iriun = {
    enable = lib.mkEnableOption "SteelSeries GG for Linux";
    user = lib.mkOption {
      type = lib.types.str;
      description = "User to add to the input group";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=10 card_label="Iriun Webcam" exclusive_caps=1
    '';
    boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };
}
