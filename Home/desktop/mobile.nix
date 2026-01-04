{ config, pkgs, lib, inputs, ... }:
{ 
  options = {
    desktop = {
      enable = lib.mkOption {
        description = "Enable desktop apps";
        type = lib.types.bool;
        default = true;
        example = false;
      };
      x64 = lib.mkOption {
        description = "Enable x64 cpu apps";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };
  config = lib.mkIf config.desktop.x64 {
    home = {
      packages = with pkgs; [
          beeper
          discord
          microsoft-edge
          spotify
      ];
    };
    #services = {
    # dunst = {
    #    enable = true;
    #   settings = {
    #     global = {
    #       follow = "mouse";
    #     };
    #   };
    # };
    #};
  };
}
