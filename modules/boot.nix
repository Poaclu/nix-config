{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    plymouth = {
      enable = lib.mkOption {
        description = "Enable plymouth for a pretty boot";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };

  config = lib.mkIf config.plymouth.enable {
    boot.plymouth.enable = true;
  };
}
