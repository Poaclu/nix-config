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
		system.stateVersion = cN.version;
	};
}
