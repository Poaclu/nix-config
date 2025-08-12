{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
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
  };

  config = lib.mkIf config.grub.enable {
    boot = {
      loader = {
        systemd-boot.enable = false;
        grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          devices = [ "nodev" ];
          timeoutStyle = config.grub.timeoutStyle;
        };
      };
    };
  };
}
