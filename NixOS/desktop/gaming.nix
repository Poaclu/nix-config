{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    gaming.enable = lib.mkOption {
      description = "Enable Gaming apps and features";
      type = lib.types.bool;
      default = true;
      example = false;
    };
  };


    imports = [
      inputs.play.nixosModules.play
    ];
  config = lib.mkIf config.gaming.enable {

    play = {
      amd.enable = true;
      steam.enable = true;
      lutris.enable = true;
      gamemode.enable = true;
      ananicy.enable = true;
    };

    environment.systemPackages = with pkgs; [
      bottles
      lutris
      mangohud
      protonup-qt
      protonplus
      r2modman
      (heroic.override {extraPkgs = pkgs: [gamescope];})
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      xone.enable = true;
    };
    services.xserver.videoDrivers = [ "amdgpu" ];
  };
}
