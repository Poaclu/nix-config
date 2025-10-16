{ config, lib, pkgs, ... }:

{
  imports = [
    ./system-config.nix
  ];
  boot.grub.enable = false;
  bluetooth.enable = true;
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  networking.hostName = "odonata";
  gaming.enable = false;
  desktop = {
    enable = true;
    x64 = false;
  };
  anti-virus.enable = false;

  #  services = {
  #  xserver = {
  #    enable = true;
  #    xkb.layout = "fr";
  #  };
  #  desktopManager.gnome.enable = true;
  #  xserver.desktopManager = {
  #    phosh = {
  #      enable = true;
  #      group = "users";
  #      user = "poaclu";
  #    };
  #    #plasma5.mobile.enable = true;
  #  };
  #  displayManager.gdm.enable = true;
  #  gnome = {
  #    gnome-keyring.enable = true;
  #    core-apps.enable = true;
  #  };
  #};

  mobile = {
    beautification = {
      silentBoot = true;
      splash = true;
    };
    boot.boot-control.enable = true;
  };

  virtualisation.waydroid.enable = true;

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

  # Enable dconf for GNOME settings
  #programs.dconf.enable = true;

  # Minimal essential packages
  # environment.systemPackages = with pkgs; [
  #  git
  #  vim
  #  wget
  #  curl
  #  home-manager
  #  lazygit
  #  asciiquarium
  #  neovim
  #  kitty
  #  phosh-mobile-settings
  #];

} 
