{config, lib, pkgs, ...}:

{

	options = {
		sudo = {
			enable
				= lib.mkEnableOption "Enable Security feature : Sudo";
			rootpw
				= lib.mkEnableOption "Enable root password for sudo";
		};
	}
	config = lib.mkIf config.sudo.enable {
		security = {
			sudo = {
				enable = true;
				extraConfig = ''
					Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff
					%wheel ALL=NOPASSWD: REBOOT
					'';
				extraConfig = lib.mkIf config.sudo.rootpw ''
					Defaults rootpw
					'';
			};
			rtkit.enable = true;
		};
	};
}

