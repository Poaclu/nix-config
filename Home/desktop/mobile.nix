{ config, pkgs, lib, inputs, ... }:
let 
  pkgsUnstable = import inputs.nixpkgs-unstable { inherit (pkgs) system; };
in
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
  config = lib.mkIf (config.desktop.enable && config.desktop.x64) {
    home = {
      packages = [
#pkgsUnstable.beeper
          pkgs.discord
          pkgs.microsoft-edge
          pkgs.spotify
      ];
    };
    nixpkgs.config.allowUnfreePredicate = pkgsUnstable: builtins.elem (lib.getName pkgsUnstable) [
      "beeper"
    ];
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
