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
			gc = lib.mkOption {
				default = true;
				type = lib.types.bool;
				description = "Enable Nix grabage colector";
			};
			upgrade = lib.mkOption {
				default = false;
				type = lib.types.bool;
				description = "Enable Nix auto upgrade";
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
			settings.experimental-features = [ "nix-command" "flakes" ];
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
