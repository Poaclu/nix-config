{ config, lib, pkgs, inputs, ... }:

let 
cpkgs = config.nixpkgs;
in
{
  options = {
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

    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}
