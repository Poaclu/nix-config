{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.poaclu = {
    swap = {
      enable = lib.mkOption {
        description = "Enable swap, only swapfile";
        type = lib.types.bool;
        default = true;
        example = false;
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = 8;
        description = "Number of gigs to pu in swap file";
      };
    };
  };
  config = lib.mkIf config.poaclu.swap.enable {
    swapDevices = [
      {
        device = "/swapfile";
        size = config.poaclu.swap.size * 1024;
      }
    ];
  };
}
