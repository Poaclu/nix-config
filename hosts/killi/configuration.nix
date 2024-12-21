{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.disko.nixosModules.default
    ./disko-config.nix
  ];
  networking.hostName = "killi";
}
