{
  config,
  lib,
  pkgs,
  ...
}:

{

  options = {
    bluetooth = {
      enable = lib.mkOption {
        description = "Enable bluetooth";
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };
  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
      settings = {
        General = {
          Experimental = true;
        };
      };
    };
    services.blueman.enable = true;
  };
}
