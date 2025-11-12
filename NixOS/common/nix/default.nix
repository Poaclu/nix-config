{ pkgs, lib, ... }:
{

  imports = [
    ./autoupgrade.nix
    ./gc.nix
    ./nixpkgs.nix
  ];
}
