{ config, pkgs, libs, inputs, ... }:
{ 
    home.packages = [
      inputs.zen-browser.homeModules.default
    ];
};
