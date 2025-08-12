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

  bluetooth.enable = true;
  boot = {
    grub.enable = false;
    sysdb.enable = true;
  };
  desktop = {
    enable = true;
    xdg = true;
  };
  gaming.enable = true;
  networking.hostName = "kermel";
}
