{ config, pkgs, lib, ... }:
{ 
  options = {
    user = {
      enable = lib.mkOption {
        description = "Enable user config for Home-manager config";
        type = lib.types.bool;
        default = true;
        example = false;
      };
      name = lib.mkOption {
        description = "Name of the user";
        type = lib.types.str;
        default = "poaclu";
      };
    };
  };  
  config = lib.mkIf config.user.enable {
    home = {
      username = config.user.name;
      homeDirectory = "/home/${config.user.name}";
    };
  };
}
