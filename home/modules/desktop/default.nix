{
  config,
  lib,
  pkgs,
  ...
}: 

{
  imports = [
    ./browser.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./lock.nix
    ./main.nix
    ./waybar.nix
  ];
}
