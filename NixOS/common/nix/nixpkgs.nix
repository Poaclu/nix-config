{
  config,
  lib,
  pkgs,
  ...
}:

let
  cpkgs = config.nixpkgs;
  cN = config.customNix;
in
{
  options = {
    customNix = {
      version = lib.mkOption {
        type = lib.types.str;
        default = "24.11";
        description = "Version of NixOS";
      };
    };
    nixpkgs = {
      enable = lib.mkOption {
        description = "Enable Nix packages";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };
  config = lib.mkIf cpkgs.enable {
    environment.systemPackages = with pkgs; [
      git
      home-manager
      mlocate
      neovim
      vim
      wget
    ];
    programs.zsh.enable = true;
    system.stateVersion = cN.version;
    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}
