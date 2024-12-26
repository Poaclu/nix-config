{ config, lib, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    lutris
    protonup-qt
    steam
    steam-run
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (builtins.parseDrvName pkg.name).name ["steam"];
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
    };
  };
}
