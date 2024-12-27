{ config, lib, pkgs, ... }:

{
	options = {
		grub.enable
			= lib.mkEnableOption "Enable Grub config";
	
	};
	
	config = lib.mkIf config.grub.enable {
		boot.loader = {
			systemd-boot.enable = false;
			grub = {
				enable = true;
				efiSupport = true;
				efiInstallAsRemovable = true;
				devices = [ "nodev"];
			};
  		};
	};
}

