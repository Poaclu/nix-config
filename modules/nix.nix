{ config, lib, pkgs, inputs, ... }:

let 
	cN = config.customNix;
in
{
	options = {
		customNix = {
			enable = lib.mkOption {
				description = "Enable Nix automatic gestion";
				type = lib.types.bool;
				default = true;
				example = false;
			};
			gc = lib.mkEnableOption "Enable Nix Garbage collector automatic gestion";
			upgrade = lib.mkOption {
				default = false;
				type = lib.types.bool;
				description = "Enable Nix auto upgrade";
			};
			flakes = lib.mkEnableOption {
				default = true;
				description = "Enable flakes in NixOS";
			};
			version = lib.mkOption {
				type = lib.types.str;
				default = "24.11";
				description = "Version of NixOS";
			};
		};
	};
	config = lib.mkIf cN.enable {
		nix = {
			settings = if cN.flakes.enable then {
				experimental-features = [ "nix-command" "flakes" ];
			} else {
				{}; # Return empty set
			};
			gc = lib.mkIf cN.gc.enable {
				automatic = true;
				dates = "weekly";
				persistent = true;
				options = "--delete-older-than 30d";
			};
		};
		system = lib.mkIf cN.upgrade {
			stateVersion = cN.version;
			autoUpgrade = {
				enable = true;
				dates = "daily";
				operation = "boot";
				flake = inputs.self.outPath;
				flags = [
					"--flake ~/sources/nix-config/"
					"--update-input"
					"nixpkgs"
					"-L" # print build logs
				];
				persistent = true;
				rebootWindow = {
					lower = "01:00";
					upper = "05:00";
				};
			};
		};
	};
}
