{ config, pkgs, lib, ... }:
{ 
  options = {
    shell.nvim = {
      enable = lib.mkOption {
        description = "Enable Shell config for neovim config";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };  
  config = lib.mkIf config.shell.nvim.enable {
    home = {
      sessionVariables = {
        EDITOR = "nvim";
      };
    };
    programs = {
      neovim.enable = true;
    };
    xdg.configFile = {
      "nvim/init.lua".source = ./config/init.lua;
    };
  };
}
