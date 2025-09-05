{
  config,
  lib,
  pkgs,
  ...
}: 

{

  options = {
    poaclu.home.nix = {
      enable = lib.mkOption {
        description = "Enable Nix config at home-manager level";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };

  config = {
    nix = lib.mkIf config.poaclu.home.nix.enable {
      package = lib.mkForce pkgs.nixVersions.latest;
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
  };
}
