{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.poaclu = {
    anti-virus.enable = lib.mkOption {
      description = "Enable Security feature : AntiVirus";
      type = lib.types.bool;
      default = true;
      example = false;
    };

  };

  config = lib.mkIf config.poaclu.anti-virus.enable {
    services.clamav = {
      daemon.enable = true;
      updater.enable = true;
      scanner = {
        enable = true;
        interval = "Sat *-*-* 04:00:00";
      };
    };
  };
}
