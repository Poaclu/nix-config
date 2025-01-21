{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  anti-virus.enable = false;
  desktop.enable = true;
  gaming.enable = false;
  networking.hostName = "dragonfly";
  swap.size = 2;

}
