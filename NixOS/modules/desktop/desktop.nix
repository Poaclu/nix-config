{
  config,
  lib,
  pkgs,
  self,
  ...
}:

let 
  cfg = config.poaclu.desktop;
  inherit (lib) mkIf mkMerge mkForce;
in {

  options.poaclu = {
    desktop = {
      enable = lib.mkEnableOption "Enable Desktop environment";
      xdg = lib.mkEnableOption "Enable XDG environment";
      x64 = lib.mkEnableOption "Enable x64 cpu apps";
    };
  };

  config = lib.mkIf config.poaclu.desktop.enable {
    #systemd.user.services.xdg-desktop-portal-gtk = {
    #wantedBy = [ "xdg-desktop-portal.service" ];
    #before = [ "xdg-desktop-portal.service" ];
    #};

      virtualisation.waydroid.enable = true;

      services = {
        picom.enable = true;
        displayManager = {
#gdm.enable = true;
          cosmic-greeter.enable = true;
        };
        desktopManager = {
          plasma6.enable = true;
          cosmic.enable = true;
        };
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };
        xserver = {
          enable = true;
          xkb.layout = "fr";
        };
      };

      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        alacritty
        alsa-utils
        cliphist
        cosmic-bg
        cosmic-wallpapers
        libnotify
        grim
        hyprpaper
        kitty
        networkmanagerapplet
        protonvpn-gui
        rofi
        slurp
        swaylock
        swww
        waybar
        wlogout
        wofi
        self.inputs.xwayland-satellite.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      programs = {
        firefox.enable = true;
        hyprland = {
          enable = true;
          xwayland.enable = true;
        };
        niri = {
          enable = true;
          package = self.inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
        };
        ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
      };
    };
}
