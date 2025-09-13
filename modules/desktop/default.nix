{ pkgs, lib, ... }:
{

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./mobile.nix
  ];
}
