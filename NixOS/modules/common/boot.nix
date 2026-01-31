{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.poaclu = {
    boot = {
      plymouth_custom = {
        enable = lib.mkOption {
          description = "Enable plymouth for a pretty boot";
          type = lib.types.bool;
          default = true;
          example = false;
        };
      };
      grub = {
        enable = lib.mkOption {
          description = "Enable Grub config";
          type = lib.types.bool;
          default = true;
          example = false;
        };
        timeoutStyle = lib.mkOption {
          default = "menu";
          type = lib.types.enum [ "menu" "countdown" "hidden" ];
          description = ''
            - `menu` shows the menu.
            - `countdown` uses a text-mode countdown.
            - `hidden` hides GRUB entirely.'';
        };
      };
      sysdb = {
        enable = lib.mkOption {
          description = "Enable Systemd-boot config";
          type = lib.types.bool;
          default = false;
          example = true;
        };
      };
    };
  };

  config = {
    boot = {
      loader = {
        systemd-boot = lib.mkIf config.poaclu.boot.sysdb.enable {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = lib.mkIf config.poaclu.boot.sysdb.enable true;
        grub = lib.mkIf config.poaclu.boot.grub.enable {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          #devices = [ "nodev" ];
          timeoutStyle = config.poaclu.boot.grub.timeoutStyle;
        };
      };
      plymouth.enable = lib.mkIf config.poaclu.boot.plymouth_custom.enable true;
    };
  };
}
