{
  config,
  lib,
  pkgs,
  self,
  ...
}:

let 
  cfg = config.poaclu.server;
  inherit (lib) mkIf mkMerge mkForce;
in {

  options.poaclu = {
    server = {
      enable = lib.mkEnableOption "Enable Desktop environment";
      xdg = lib.mkEnableOption "Enable XDG environment";
      x64 = lib.mkEnableOption "Enable x64 cpu apps";
    };
  };


  config = lib.mkIf cfg.enable {
    services = {
      haproxy= {
        enable = true;

      };
    };
  };
}
