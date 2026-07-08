{
  config,
  lib,
  pkgs,
  ...
}: 

{
  imports = [
    ./browser.nix
    ./hyprlock.nix
    ./lock.nix
    ./main.nix
    ./mobile.nix
    ./waybar.nix
  ];
}
