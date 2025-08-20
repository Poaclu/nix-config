{ config, inputs, pkgs, lib, ... }:
{
	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
		settings = {
			monitor = [
				"desc:LG Electronics LG ULTRAGEAR 308MAHUCD521, preferred, 0x0, auto, vrr, 1, cm, hdredid"
					"desc:Samsung Electric Company LF27T35 HK2T402563, preferred, auto-center-left, auto, vrr, 1, cm, edid"
					"desc:Samsung Electric Company S19C450 H4MG101147, preferred, auto-center-right, auto, vrr, 1, cm, edid"
					"desc:AU Optronics 0x499F,prefered,auto,1,vrr,1"
					", preferred, auto, auto, vrr, 1, cm, auto"
			];
			"$terminal" = "kitty";
			"$fileManager" = "nautilus";
			"$apps" = "wofi --show drun";
			"$browser" = "zen-beta";
			"$menu" = "pkill wlogout || wlogout";
			"$lock" = "hyprlock";
			exec-once = [ 
				"$terminal"
				"nm-applet --indicator &"
				"sleep 1 && systemctl --user start waybar.service"
				"swww-daemon &"
				"$browser"
				"discord"
				"discover-overlay"
				"steam"
				"heroic"
				"obsidian"
			];
			ecosystem = {
				no_update_news = true;
				no_donation_nag = true;
			};
			general = { 
				gaps_in = 5;
				gaps_out = 5;
				border_size = 2;
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";
				resize_on_border = false;
				allow_tearing = false;
				layout = "dwindle";
			};
			render = {
				direct_scanout = 2;
				cm_fs_passthrough = 2;
			};
			decoration = {
				rounding = 10;
				active_opacity = 1.0;
				inactive_opacity = 1.0;
				blur = {
					enabled = true;
					size = 3;
					passes = 1;
					vibrancy = 0.1696;
				};
			};
			animations = {
				enabled = true;
				bezier = "myBezier, 0.6, -0.28, 0.735, 0.045";
			};
			workspace = [
				"10, monitor:DP-2"
			];
			dwindle = {
				pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section belou
					preserve_split = true; # You probably want this
			};
#master = {
#	new_status = master;
#};
			misc = { 
				vrr = 1;
				force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
					disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
							};
							input = {
							kb_layout = "fr";
							follow_mouse = 1;
							sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
							numlock_by_default = true;
							touchpad = {
							natural_scroll = true;
							};
							};
							gestures = {
							workspace_swipe = false;
							};
							device = {
							name = "epic-mouse-v1";
							sensitivity = -0.5;
							};
							"$mainMod" = "SUPER"; # Sets "Windows" key as main modifier";
							bind = [ 
							"$mainMod, Return, exec, $terminal"
							"$mainMod, Q, killactive,"
#"$mainMod, M, exit,"
							"$mainMod, E, exec, $fileManager"
							"$mainMod, V, togglefloating,"
							"$mainMod, R, exec, $apps"
							"$mainMod, P, pseudo, # dwindle"
							"$mainMod, J, togglesplit, # dwindle"
							"$mainMod, B, exec, brave"
							"$mainMod, F, exec, $browser"
							"$mainMod, L, exec, $lock"
							"Control_L Alt_L, Delete, exec, $menu"
							"$mainMod, left, movefocus, l"
							"$mainMod, right, movefocus, r"
							"$mainMod, up, movefocus, u"
							"$mainMod, down, movefocus, d"
							"$mainMod, $desk1, workspace, 1"
							"$mainMod, $desk2, workspace, 2"
							"$mainMod, $desk3, workspace, 3"
							"$mainMod, $desk4, workspace, 4"
							"$mainMod, $desk5, workspace, 5"
							"$mainMod, $desk6, workspace, 6"
							"$mainMod, $desk7, workspace, 7"
							"$mainMod, $desk8, workspace, 8"
							"$mainMod, $desk9, workspace, 9"
							"$mainMod, $desk10, workspace, 10"
							"$mainMod SHIFT, $desk1, movetoworkspace, 1"
							"$mainMod SHIFT, $desk2, movetoworkspace, 2"
							"$mainMod SHIFT, $desk3, movetoworkspace, 3"
							"$mainMod SHIFT, $desk4, movetoworkspace, 4"
							"$mainMod SHIFT, $desk5, movetoworkspace, 5"
							"$mainMod SHIFT, $desk6, movetoworkspace, 6"
							"$mainMod SHIFT, $desk7, movetoworkspace, 7"
							"$mainMod SHIFT, $desk8, movetoworkspace, 8"
							"$mainMod SHIFT, $desk9, movetoworkspace, 9"
							"$mainMod SHIFT, $desk10, movetoworkspace, 10"
							"$mainMod, S, togglespecialworkspace, magic"
							"$mainMod SHIFT, S, movetoworkspace, special:magic"
							"$mainMod, mouse_down, workspace, e+1"
							"$mainMod, mouse_up, workspace, e-1"
							];
				"$desk1" = "ampersand";
				"$desk2" = "eacute";
				"$desk3" = "quotedbl";
				"$desk4" = "apostrophe";
				"$desk5" = "parenleft";
				"$desk6" = "minus";
				"$desk7" = "egrave";
				"$desk8" = "underscore";
				"$desk9" = "ccedilla";
				"$desk10" = "agrave";
				bindl = [
					", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"
					", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%-"
					", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
					", XF86AudioPlay, exec, playerctl play-pause"
					", XF86AudioNext, exec, playerctl next"
					", XF86AudioPrev, exec, playerctl previous"
					", XF86MonBrightnessUp, exec, brightnessctl s +10%"
					", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
				];
				bindm = [ 
					"$mainMod, mouse:272, movewindow"
					"$mainMod, mouse:273, resizewindow"
				];
				windowrulev2 = [ 
					"suppressevent maximize, class:.*" # You'll probably like this.
					"workspace 2,class:($browser)"
					"workspace 7,class:(steam)"
					"workspace 8,class:(obsidian)"
					"workspace 9,class:(discord)"
					"workspace 10,class:(pavucontrol)"
				];
		};
	};
}
