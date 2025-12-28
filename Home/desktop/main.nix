{ pkgs, ... }:
let 
  myMPVConfig = ''
        fullscreen=yes
        save-position-on-quit=yes
        keep-open=yes
        volume-max=100
        vo=gpu-next
        gpu-api=vulkan
        gpu-context=auto
        target-colorspace-hint=auto
        target-contrast=auto
        target-trc=auto
        hwdec=auto-safe
        profile=gpu-hq
        deband=yes
        scale=ewa_lanczossharp
        cscale=ewa_lanczossharp
        dscale=mitchell
  '';
in { 
    home = {
      packages = with pkgs; [
        brave
        brightnessctl
        cachix
        discover-overlay
        font-awesome
        jellyfin-mpv-shim
      #kodi-wayland
      # kodiPackages.jellyfin
      # kodiPackages.jellycon
      # kodiPackages.joystick
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
      kodi = {
        enable = true;
        package = pkgs.kodi-wayland;
      };
    };

	  xdg.configFile = {
      "mpv/mpv.conf".text = myMPVConfig;
      "jellyfin-mpv-shim/mpv.conf".text = myMPVConfig;
		  "niri/config.kdl".source = ./config/config.kdl;
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
