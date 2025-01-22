{ config, lib, pkgs, inputs, ... }:

let 
	cN = config.customNix;
in
{
	options = {
		customNix = {
			upgrade = lib.mkOption {
				default = false;
				type = lib.types.bool;
				description = "Enable Nix auto upgrade";
			};
		};
	};
	config = lib.mkIf cN.enable {
		system = lib.mkIf cN.upgrade {
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
