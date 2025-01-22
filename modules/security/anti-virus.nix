{ config, lib, pkgs, ... }:

{
	options = {
		anti-virus.enable = lib.mkOption {
				description = "Enable Security feature : AntiVirus";
				type = lib.types.bool;
				default = true;
				example = false;
		};
	
	};
	
	config = lib.mkIf config.anti-virus.enable {
		services.clamav = {
    			daemon.enable = true;
			updater.enable = true;
			scanner.enable = true;
			fangfrisch.enable = true;
  		};
	};
}

