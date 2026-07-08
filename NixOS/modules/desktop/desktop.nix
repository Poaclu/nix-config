{
  config,
  lib,
  pkgs,
  ...
}:

let 
  cfg = config.poaclu.desktop;
in {

  options.poaclu = {
    desktop = {
      enable = lib.mkEnableOption "Enable Desktop environment";
      xdg = lib.mkEnableOption "Enable XDG environment";
      x64 = lib.mkEnableOption "Enable x64 cpu apps";
    };
  };


  config = lib.mkIf cfg.enable {
      services = {
        displayManager = {
          defaultSession = null;
          gdm.enable = true;
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
        kdePackages.qtwebsockets
        python3Minimal
      ];

      programs = {
        firefox.enable = true;
        ssh.askPassword = lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
      };
      virtualisation = lib.mkIf cfg.x64 {
        virtualbox.host.enable = true;
        waydroid.enable = true;
      };
      users.extraGroups.vboxusers.members = [ "poaclu" ];
    };
}
