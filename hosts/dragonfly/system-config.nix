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
    options = [ "bind" ];
  };

}
