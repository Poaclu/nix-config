{ config, pkgs, libs, inputs, ... }:
{ 
    home = {
      packages = with pkgs; [
        brave
        brightnessctl
          discord
          discover-overlay
          font-awesome
          libmpdclient
          microsoft-edge
          nautilus
          obsidian
          parsec-bin
          pavucontrol
          playerctl
          prismlauncher
          protonvpn-gui
          spotify
	  swww
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
    services.flameshot = {
      enable = true;
    };
}
