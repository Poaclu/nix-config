{ config, lib, pkgs, inputs, ... }:

{
  systemd.user.services.xdg-desktop-portal-gtk = {
    wantedBy = [ "xdg-desktop-portal.service" ];
    before = [ "xdg-desktop-portal.service" ];
  };

  services = {
    picom.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      xkb.layout = "fr";
    };
  };
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
    wlr = {
      enable = true;
      settings = { # uninteresting for this problem, for completeness only
        screencast = {
	  output_name = "eDP-1";
	  max_fps = 30;
	  chooser_type = "simple";
	  chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
	};
      };
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    cliphist
    dunst
    libnotify
    #firefox
    grim
    hyprpaper
    kitty
    networkmanagerapplet
    rofi-wayland
    slurp
    swaylock
    swww
    waybar
    wlogout
    wofi
  ];
  
  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

}
