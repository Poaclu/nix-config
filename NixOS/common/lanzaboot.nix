{
  config,
  lib,
  pkgs,
  lanzaboote,
  ...
}:

{
  options.poaclu = {
    boot = {
      lanza = {
        enable = lib.mkOption {
          description = "Enable Systemd-boot config";
          type = lib.types.bool;
          default = false;
          example = true;
        };
        pkiBundle = lib.mkOption {
          default = "/etc/secureboot/";
          type = lib.types.str;
          description = ''
            the path to a directory where your Secure Boot key pair and certificates are stored.
            Ex:
            /var/lib/sbctl/
            /etc/secureboot/'';
        };
      };
    };
  };

  config = lib.mkIf config.poaclu.boot.lanza.enable {
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
        pkiBundle = config.poaclu.boot.lanza.pkiBundle;
        configurationLimit = 10;
      };
    };
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
