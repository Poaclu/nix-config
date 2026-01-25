{
  config,
  lib,
  pkgs,
  ...
}:

let
  cpkgs = config.poaclu.nixpkgs;
  cN = config.poaclu.customNix;
in
{
  options.poaclu = {
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
    nix = {
      optimise.automatic = true;
      extraOptions = "!include ${config.age.secrets.gh_token.path}";
    };
    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}
