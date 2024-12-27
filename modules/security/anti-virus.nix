{ config, lib, pkgs, ... }:

{
	options = {
		anti-virus.enable
			= lib.mkEnableOption "Enable Security feature : AntiVirus";
	
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

