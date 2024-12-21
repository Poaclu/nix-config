{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.default
    ./disko-config.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "killi";
}
