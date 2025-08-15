{
  config,
  lib,
  pkgs,
  ...
}: 

{
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./lock.nix
    ./main.nix
    ./waybar.nix
  ];
}
