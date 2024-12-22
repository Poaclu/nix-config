{ config, lib, pkgs, inputs, ... }:

{
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
  };
  environment.systemPackages = with pkgs; [
    protonup-qt
  ];
}
