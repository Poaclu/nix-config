{ config, pkgs, libs, inputs, ... }:
{ 
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
}
