{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    sysdb = {
      enable = lib.mkOption {
        description = "Enable Systemd-boot config";
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };

  config = lib.mkIf config.sysdb.enable {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
