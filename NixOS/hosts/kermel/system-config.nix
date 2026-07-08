{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  fileSystems."/etc/nixos" = {
    device = "/home/poaclu/sources/nix-config";
    fsType = "none";
    options = [ "bind" ];
  };

}
