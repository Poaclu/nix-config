{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.poaclu = {
    gaming.enable = lib.mkOption {
      description = "Enable Gaming apps and features";
      type = lib.types.bool;
      default = true;
      example = false;
    };
  };


  config = lib.mkIf (config.poaclu.desktop.enable && config.poaclu.gaming.enable) {
    boot = {
      initrd.kernelModules = [ "amdgpu" ];
      kernelParams = [
        "video=DP-1:2560x1440@165"
        "video=HDMI-A-1:1920x1080@75"
      ];
    };

    programs = {
      steam.enable = true;
      gamemode.enable = true;
    };

    services.ananicy.enable = true;

    environment.systemPackages = with pkgs; [
      bottles
      clinfo
      lutris
      mangohud
      gamescope
      protonup-qt
      protonplus
      r2modman
      (heroic.override {extraPkgs = pkgs: [
        gamescope
        unzip
      ];})
    ];
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];
      };
      xpadneo.enable = true;
    };
    services.xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
    };
  };
}
