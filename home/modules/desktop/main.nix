{ config, pkgs, libs, inputs, ... }:
{ 
    home = {
      packages = with pkgs; [
        brave
        brightnessctl
        cachix
          discover-overlay
          font-awesome
          libmpdclient
          hyprshot
          nautilus
          obsidian
          parsec-bin
          pavucontrol
          playerctl
          prismlauncher
          protonvpn-gui
	  swww
      trayscale
          xfce.thunar
      ];
    };

    programs = {
      kitty = {
        enable = true;
        themeFile = "GruvboxMaterialDarkHard";
        settings = {
          font_family = "Liberation Mono";
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
          font_size = 8.0;
          background_opacity = 0.7;
          dynamic_background_opacity = "yes";
        };
      };
    };
    services = {
      dunst = {
        enable = true;
        settings = {
          global = {
            follow = "mouse";
          };
        };
      };
    };
}
