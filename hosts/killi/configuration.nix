{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    inputs.disko.nixosModules.default
    ./disko-config.nix
    ./hardware-configuration.nix
    ./system-config.nix
  ];

  customNix.upgrade = true;
  desktop.enable = true;
  gaming.enable = true;
  networking.hostName = "killi";
}
