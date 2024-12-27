{ config, lib, pkgs, ... }:

{
	options = {
		swap = {
			enable = lib.mkEnableOption "Enable swap, only swapfile";
			size = lib.mkOption {
				type = lib.types.int;
				default = 8;
				description = "Number of gigs to pu in swap file";
			};
		};
	};
	config = lib.mkIf config.swap.enable {
		swapDevices = [{
			device = "/swapfile";
			size = config.swap.size * 1024;
		}];
	};
}
