{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];
  fileSystems."/etc/nixos/" = {
    device = "/home/poaclu/sources/nix-config/";
    options = [ "bind" ];
  };
  networking.hostName = "dragonfly";
}
