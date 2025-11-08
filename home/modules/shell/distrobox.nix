{ config, pkgs, lib, ... }:
{ 
  options = {
    shell.distrobox = {
      enable = lib.mkOption {
        description = "Enable distrobox";
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };  
  config = lib.mkIf config.shell.distrobox.enable {
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
