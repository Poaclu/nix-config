{ pkgs, lib, ... }: {

  imports = [
    ./security/anti-virus.nix
  ];

  anti-virus.enable = 
    lib.mkDefault true;
}
