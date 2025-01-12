{ config, lib, pkgs, ... }:

{
	options = {
		grub.enable = lib.mkOption {
				description = "Enable Grub config";
				type = lib.types.bool;
				default = true;
				example = false;
		};
	
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

