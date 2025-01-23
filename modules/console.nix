{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    console_fr = {
      enable = lib.mkOption {
        description = "Enable french console";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };

  config = lib.mkIf config.console_fr.enable {
    i18n.defaultLocale = "fr_FR.UTF-8";
    console.keyMap = "fr";
  };
}
