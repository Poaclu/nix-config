{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    bottles
    heroic
    lutris
    mangohud
    protonup-qt
    steam
    steam-run
  ];
  hardware = {
	graphics = {
		enable = true;
		enable32Bit = true;
	};
	xone.enable = true;
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name ["steam"];
  programs = {
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
    };
    gamemode.enable = true;
  };
  services.xserver.videoDrivers = ["amdgpu"];
}
