{ pkgs, lib, ... }:
{

  imports = [
    ./boot.nix
    ./console.nix
    ./desktop.nix
    ./gaming.nix
    ./nix/default.nix
    ./network.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
    ./swap.nix
    ./user.nix
  ];
}
