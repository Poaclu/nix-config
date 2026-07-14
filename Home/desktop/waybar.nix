{ 
  config,
  lib,
  ...
}:
let 
	cfg = config.poaclu.home.desktop;
in {
  config = lib.mkIf cfg.enable {

	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				layer = "top";
				height = 30;
				spacing = 8;
				modules-left = [ "cpu" "memory" "temperature" "custom/separator" "niri/window" ];
				modules-center = [ "clock" "hyprland/workspaces" "niri/workspaces" ];
				modules-right = [ "battery" "bluetooth" "tray" "network" "pulseaudio" "custom/power" ];
        "niri/window" = {
	        "format" = "{title}";
        };
				"niri/workspaces" = {
					format = "{index}";
				};
				"hyprland/workspaces" = {
					format = "{name}";
					format-icons = {
						"1" = "1";
						"2" = "2";
						"3" = "3";
						"4" = "4";
						"5" = "5";
						"6" = "6";
						"7" = "7";
						"8" = "8";
						"9" = "9";
						"10" = "10";
					};
				};
				keyboard-state = {
					numlock = true;
					capslock = true;
					format = "{name} {icon}";
					format-icons = {
						locked = "";
						unlocked = "";
					};
				};
				tray = {
					icon-size = 21;
					spacing = 10;
				};
				clock = {
					tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					format-alt = "{:%a %d/%m/%Y}";
				};
				cpu = {
					format = " {usage}% ";
					tooltip = false;
				};
				memory.format = "{}% ";
				temperature = {
					critical-threshold = 80;
					format = "{temperatureC}°C {icon}";
					format-icons = ["" "" ""];
				};
				network = {
					format-wifi = "{essid} ({signalStrength}%) ";
					format-ethernet = "{ipaddr}/{cidr} ";
					tooltip-format = "{ifname} via {gwaddr} ";
					format-linked = "{ifname} (No IP) ";
					format-disconnected = "Disconnected ⚠";
					format-alt = "{ifname}: {ipaddr}/{cidr}";
				};
				pulseaudio = {
					format = "{volume}% {icon} {format_source}";
					format-bluetooth = "{volume}% {icon} {format_source}";
					format-bluetooth-muted = " {icon} {format_source}";
					format-muted = " {format_source}";
					format-source = "{volume}% ";
					format-source-muted = "";
					format-icons = {
						headphone = "";
						hands-free = "";
						headset = "";
						phone = "";
						portable = "";
						car = "";
						default = ["" "" ""];
					};
					on-click = "pavucontrol";
				};
				"custom/media" = {
					format = "{icon} {text}";
					return-type = "json";
					max-length = 40;
					format-icons = {
						spotify = "";
						default = "🎜";
					};
					escape = true;
					exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
				};
				"custom/power" = {
					format = "⏻ ";
					tooltip = false;
					#menu = "on-click";
					#menu-file = "$HOME/.config/waybar/power_menu.xml";
					#menu-actions = {
					#	shutdown = "shutdown";
					#	reboot = "reboot";
					#	suspend = "systemctl suspend";
					#	hibernate = "systemctl hibernate";
					#};
					on-click = "wlogout";
				};
        "custom/separator" = {
          format = "|";
        };
			};
		};
		style =
			"
			* {
				font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif, Segoe UI, Ubuntu;
				font-size: 13px;
			}
			window#waybar{
				all:unset;
				background-color: rgba(43, 48, 59, 0.5);
				border-bottom: 3px solid rgba(100, 114, 125, 0.5);
				color: #ffffff;
				transition-property: background-color;
				transition-duration: .5s;
			}
			window#waybar.hidden {
				opacity: 0.2;
			}
			#workspaces button {color: white;}
			#workspaces button.active {
				background: #4c566a;
				color: #eceff4;
				font-weight: bold;
				padding: 0 6px;
			}
			#workspaces button:hover {background: #444;}
			#workspaces button.urgent { background: #bf616a; color: #ffffff; }
			#workspaces button.visible { outline: 1px solid #000000; }
			.modules-left {
				border-radius:10px;
				box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
			}
			";
	};
	xdg.configFile = {
		"waybar/mediaplayer.py".source = ./config/mediaplayer.py;
		"waybar/power_menu.xml".source = ./config/power_menu.xml;
	};
  };
}
