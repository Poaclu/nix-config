{ pkgs, lib, ... }:
{

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./touch.nix
  ];
}
