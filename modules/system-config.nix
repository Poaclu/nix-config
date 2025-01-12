{ config, lib, pkgs, inputs, ... }:

{
  fileSystems."/etc/nixos" = {
    device = "/home/poaclu/sources/nix-config";
    options = [ "bind" ];
  };

  networking = {
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    enableIPv6 = false;
  };
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
    keyMap = "fr";
  };
  services.tailscale.enable = true;
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
