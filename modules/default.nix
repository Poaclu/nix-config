{ pkgs, lib, ... }:
{

  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./console.nix
    ./desktop.nix
    ./gaming.nix
    ./lanzaboot.nix
    ./nix/default.nix
    ./network.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
    ./swap.nix
    ./user.nix
  ];
}
