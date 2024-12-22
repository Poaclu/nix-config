{ config, lib, pkgs, inputs, ... }:

{
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    scanner.enable = true;
    fangfrisch.enable = true;
  };
}

