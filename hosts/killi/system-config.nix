{ config, lib, pkgs, inputs, ... }:

{
  fileSystems."/etc/nixos" = {
    device = "/home/poaclu/sources/nix-config";
    options = [ "bind" ];
  };

  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    keyMap = "fr";
  };
}
