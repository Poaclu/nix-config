{ pkgs, lib, ... }:
{

  imports = [
    ./bluetooth.nix
    ./boot.nix
    ./console.nix
    ./desktop.nix
    ./gaming.nix
    ./grub.nix
    ./nix/default.nix
    ./network.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
    ./systemd-boot.nix
    ./swap.nix
    ./user.nix
  ];
}
