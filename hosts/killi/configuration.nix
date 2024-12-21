{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    disko.nixosModules.diko
    ./disko-config.nix
  ];
  networking.hostName = "killi";
}
