{ config, lib, pkgs, ... }:

{
	options = {
		gaming.enable
			= lib.mkEnableOption "Enable Gaming apps and features";
	};

	config = lib.mkIf config.gaming.enable {

		environment.systemPackages = with pkgs; [
			bottles
				heroic
				lutris
				mangohud
				protonup-qt
				steam
				steam-run
		];
		hardware = {
			graphics = {
				enable = true;
				enable32Bit = true;
			};
			xone.enable = true;
		};
		nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name ["steam"];
		programs = {
			steam = {
				enable = true;
				gamescopeSession.enable = true;
				remotePlay.openFirewall = true;
			};
			gamemode = {
				enable = true;
				enableRenice = true;
			};
		};
		services.xserver.videoDrivers = ["amdgpu"];
	};
}
