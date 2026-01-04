{ config, lib, pkgs, ... }:

{
  imports = [
    ./system-config.nix
  ];
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  networking.hostName = "odonata";
  poaclu ={
    boot = {
      grub.enable = false;
      plymouth_custom.enable = false;
    };
    gaming.enable = false;
    anti-virus.enable = false;
    bluetooth.enable = true;
    desktop = {
      enable = true;
      x64 = false;
      touch = true;
    };
  };

  mobile = {
    beautification = {
      silentBoot = true;
      splash = true;
    };
    boot.boot-control.enable = true;
  };


  boot = {
    initrd.verbose = false;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "loglevel=3"
      "udev.log_priority=3"
      "systemd.show_status=false"
      "vt.global_cursor_default=0"
      "splash"
      "reboot=hard"
      "panic=3"
    ];
  };

} 
