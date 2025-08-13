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
        systemd-boot = {
          enable = lib.mkForce false;
          consoleMode = "0";
        };
        timeout = 0;
      };
      lanzaboote = {
        enable = true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
    environment.systemPackages = with pkgs; [
      sbctl
    ];
  };
}
