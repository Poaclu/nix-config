{config, lib, pkgs, ...}:

{

  options = {
    network = {
      enable = lib.mkOption {
	description = "Enable Security feature : Sudo";
	type = lib.types.bool;
	default = true;
	example = false;
      };
    };
  };
  config = lib.mkIf config.network.enable {
    networking = {
      networkmanager.enable = true;  # Easiest to use and most distros use this by default.
      enableIPv6 = false;
    };
    time.timeZone = "Europe/Paris";
    services.tailscale.enable = true;
  };
}

