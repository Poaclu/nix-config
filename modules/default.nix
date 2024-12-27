{ pkgs, lib, ... }: {

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./security/anti-virus.nix
  ];

  anti-virus.enable = 
    lib.mkDefault true;
}
