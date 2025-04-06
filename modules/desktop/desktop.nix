{
  config,
  lib,
  pkgs,
  ...
}:

{

  options = {
    desktop = {
      enable = lib.mkEnableOption "Enable Desktop environment";
    };
  };

  config = lib.mkIf config.desktop.enable {

    services = {
      picom.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable= true;
      };
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        xkb.layout = "fr";
      };
    };

    environment.systemPackages = with pkgs; [
      alacritty
      cliphist
      dunst
      libnotify
      grim
      hyprpaper
      kitty
      networkmanagerapplet
      rofi-wayland
      rustdesk-flutter
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
  };
}
