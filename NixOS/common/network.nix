{
  config,
  lib,
  pkgs,
  ...
}:

{

  options.poaclu = {
    network = {
      enable = lib.mkOption {
        description = "Enable Security feature : Sudo";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };
  config = lib.mkIf config.poaclu.network.enable {
    environment.systemPackages = [
      pkgs.networkmanagerapplet
    ];
    networking = {
      networkmanager.enable = true; # Easiest to use and most distros use this by default.
      enableIPv6 = false;
    };
    time.timeZone = "Europe/Paris";
    services = {
      tailscale = {
        enable = true;
        authKeyFile = config.age.secrets.tailscale.path;
        extraUpFlags = [
          "--ssh"
          "--accept-dns"
          "--accept-routes"
        ];
        extraSetFlags = [ "--operator=poaclu" ];
      };
      openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          LoginGraceTime = 0;
          PermitRootLogin = "no";
        };
      };
    };
  };
}
