{ config, pkgs, libs, inputs, ... }:
{ 
    home = {
      packages = with pkgs; [
        brave
        brightnessctl
        cachix
        discover-overlay
        font-awesome
        jellyfin-mpv-shim
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
      mpv = {
        enable = true;
      };
    };

	  xdg.configFile."mpv/mpv.conf".text = ''
      vo=gpu-next
      gpu-api=vulkan
      hwdec=vaapi
      hdr-compute-peak=yes
      tone-mapping=auto
    '';
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
