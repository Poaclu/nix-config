{config, lib, pkgs, ...}:

{

	options = {
		sudo = {
			enable = lib.mkOption {
				description = "Enable Security feature : Sudo";
				type = lib.types.bool;
				default = true;
				example = false;
			};
			rootpw = lib.mkOption {
				description = "Enable root password for sudo";
				type = lib.types.bool;
				default = true;
				example = false;
			};
		};
	};
	config = lib.mkIf config.sudo.enable {
		security = {
			sudo = {
				enable = true;
				extraConfig = ''
					Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff
					%wheel ALL=NOPASSWD: REBOOT
					'' + lib.optionalString config.sudo.rootpw ''
					Defaults rootpw
					'';
			};
			rtkit.enable = true;
		};
		users.extraUsers.root.hashedPassword = "$y$j9T$a2bKTub3XJC7xhQnj7Nlz/$/2xcWL7AmVF/5cM/2ED7WkTQUhLokASdqgl3goIFgA3";
	};
}

