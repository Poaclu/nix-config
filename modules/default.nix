{ pkgs, lib, ... }: {

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./grub.nix
    ./nix/default.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
    ./swap.nix
    ./user.nix
  ];
}
