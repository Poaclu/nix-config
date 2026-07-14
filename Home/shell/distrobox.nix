{ config, pkgs, lib, ... }:
{ 
  options.poaclu.home = {
    shell.distrobox = {
      enable = lib.mkOption {
        description = "Enable distrobox";
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };  
  config = lib.mkIf config.poaclu.home.shell.distrobox.enable {
    programs = {
      distrobox = {
        enable = true;
      };
    };
    home = {
      packages = with pkgs; [
        distroshelf
      ];
    };
  };
}
