{
  config,
  lib,
  pkgs,
  ...
}: 

{

  options.poaclu.home.desktop.enable = lib.mkOption {
    description = "Enable Desktop config at home-manager level";
    type = lib.types.bool;
    default = false;
    example = true;
  };

  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./lock.nix
    ./main.nix
    ./waybar.nix
  ];
}
