{
  config,
  lib,
  pkgs,
  lanzaboote,
  ...
}:

{
  options = {
    boot = {
      lanza = {
        enable = lib.mkOption {
          description = "Enable Systemd-boot config";
          type = lib.types.bool;
          default = false;
          example = true;
        };
      };
    };
  };

  config = lib.mkIf config.boot.lanza.enable {
    boot = {
      loader = {
        efi = {
          canTouchEfiVariables = true;
        };
        grub.enable = lib.mkForce false;
        systemd-boot = {
          enable = lib.mkForce false;
          consoleMode = "0";
        };
        timeout = 0;
      };
      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot/";
      };
    };
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
