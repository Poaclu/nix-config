{config, lib, pkgs, ...}:

{
  options = {
    console = {
      enable = lib.mkOption {
	description = "Enable french console";
	type = lib.types.bool;
	default = true;
	example = false;
      };
    };
  };

  config = lib.mkIf config.console.enable {
    i18n.defaultLocale = "fr_FR.UTF-8";
    console.keymap = "fr";
  };
}

