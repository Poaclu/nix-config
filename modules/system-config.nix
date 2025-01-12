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
  users.users.poaclu = {
    description = "Poaclu";
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "12345";
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "mlocate"
    ];
  };
  users.extraUsers.root.initialPassword = "678910";
}
