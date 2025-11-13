{ 
  lib,
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;
  nix.package = lib.mkForce pkgs.nixVersions.latest;
}
