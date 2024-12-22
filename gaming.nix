{ config, lib, pkgs, inputs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    protonup-qt
  ];
}
