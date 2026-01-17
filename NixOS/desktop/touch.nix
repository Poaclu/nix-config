{
  config,
  lib,
  pkgs,
  ...
}:

let 
  cfg = config.poaclu.desktop;
  inherit (lib) mkIf mkMerge mkForce;
in {

  options.poaclu = {
    desktop = {
      touch = lib.mkOption {
        description = "Enable touch compatible DE";
        type = lib.types.bool;
        default = false;
        example = true;
      };
    };
  };

  config = lib.mkIf (config.poaclu.desktop.enable && config.poaclu.desktop.touch) {
    services = {
      desktopManager.gnome.enable = true;


      xserver = {
        enable = true;
        xkb.layout = "fr";
      };
      #xserver.desktopManager = {
      #  phosh = {
      #    enable = true;
      #    group = "users";
      #    user = "poaclu";
      #  };
        #plasma5.mobile.enable = true;
    gnome = {
      gnome-keyring.enable = true;
      core-apps.enable = true;
    };

    };
    environment.systemPackages = with pkgs; [
      kdePackages.plasma-mobile
      phosh-mobile-settings
    ];
  };
}
