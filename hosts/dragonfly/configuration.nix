{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    #inputs.disko.nixosModules.default
    #./disko-config.nix
    ./hardware-configuration.nix
    ./system-config.nix
  ];

  anti-virus.enable = false;
  desktop = {
    enable = true;
    xdg = true;
  };
  bluetooth.enable = true;
  gaming.enable = false;
  networking.hostName = "dragonfly";
  swap.size = 2;

}
