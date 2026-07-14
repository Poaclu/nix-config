{ config, lib, ... }:
{ 
  options.poaclu.home = {
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
  config = lib.mkIf config.poaclu.home.user.enable {
    home = {
      username = config.poaclu.home.user.name;
      homeDirectory = "/home/${config.poaclu.home.user.name}";
    };
  };
}
