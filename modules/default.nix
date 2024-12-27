{ pkgs, lib, ... }: {

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
  ];

  anti-virus.enable = 
    lib.mkDefault true;
  sudo.enable =
    lib.mkDefault true;
  sudo.rootpw = 
    lib.mkDefault true;
}
