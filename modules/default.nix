{ pkgs, lib, ... }: {

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./grub.nix
    ./nix.nix
    ./nix/gc.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
    ./swap.nix
  ];
}
