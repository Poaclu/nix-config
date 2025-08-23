{ pkgs, lib, ... }:
{

  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./console.nix
    ./lanzaboot.nix
    ./nix/default.nix
    ./network.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
    ./swap.nix
    ./user.nix
  ];
}
