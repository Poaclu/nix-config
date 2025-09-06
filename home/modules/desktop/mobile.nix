{ config, pkgs, lib, inputs, ... }:
{ 
  options = {
    desktop = {
      enable = lib.mkOption {
        description = "Enable x64 cpu apps";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };
  config = lib.mkIf config.desktop.enable {
    home = {
      packages = with pkgs; [
          discord
          microsoft-edge
          spotify
      ];
    };
    services = {
      dunst = {
        enable = true;
        settings = {
          global = {
            follow = "mouse";
          };
        };
      };
      flameshot = {
        enable = true;
      };
    };
  };
}
