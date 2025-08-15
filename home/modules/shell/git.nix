{ config, pkgs, lib, ... }:
{ 
  options = {
    shell.git = {
      enable = lib.mkOption {
        description = "Enable Shell config for user config";
        type = lib.types.bool;
        default = true;
        example = false;
      };
      user = lib.mkOption {
        description = "Git Username to use";
        type = lib.types.str;
        default = "Poaclu";
      };
      mail = lib.mkOption {
        description = "Git e-mail to use";
        type = lib.types.str;
        default = "25772718+Poaclu@users.noreply.github.com";
      };
    };
  };  
  config = lib.mkIf config.shell.git.enable {
    programs = {
      git = {
        enable = true;
        userName = config.shell.git.user;
        userEmail = config.shell.git.mail;
      };
    };
  };
}
