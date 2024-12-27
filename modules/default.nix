{ pkgs, lib, ... }: {

  imports = [
    ./desktop.nix
    ./gaming.nix
    ./grub.nix
    ./security/anti-virus.nix
    ./security/sudo.nix
  ];

  anti-virus.enable = 
    lib.mkDefault true;
  grub = {
  	enable = lib.mkDefault true;
  };
  sudo = {
  	enable = lib.mkDefault true;
	rootpw = lib.mkDefault true;
  };
}
