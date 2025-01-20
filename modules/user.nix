{config, lib, pkgs, ...}:

{
  options = {
    user = {
      enable = lib.mkOption {
	description = "Enable Security feature : Sudo";
	type = lib.types.bool;
	default = true;
	example = false;
      };
      username = {
	enable = lib.mkOption {
	  description = "Enable Security feature : Sudo";
	  type = lib.types.str;
	  default = "Poaclu";
	};
      };
    };
  };
  config = lib.mkIf config.user.enable {
    users.users = {
      config.user.username = {
	description = "Poaclu";
	isNormalUser = true;
	shell = pkgs.zsh;
	initialPassword = "12345";
	extraGroups = [ 
	  "wheel"
	  "networkmanager"
	  "mlocate"
	];
      };
    };
  };
}
