# Minimal configuration for OnePlus 6 (enchilada) NixOS Mobile
# Focus on essentials: SSH, wireless, and basic tools

{ config, lib, pkgs, ... }:

{
  imports = [
    ./system-config.nix
  ];
  boot.grub.enable = false;
  # Allow unfree packages (needed for OnePlus firmware)
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

  # Enable SSH server (essential for mobile device access)
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes"; # For initial setup
        PasswordAuthentication = true; # For initial setup
      };
    };
    xserver = {
      enable = true;
      xkb.layout = "fr";
    };
    desktopManager.gnome.enable = true;
    xserver.desktopManager = {
      phosh = {
        enable = true;
        group = "users";
        user = "poaclu";
      };
      #plasma5.mobile.enable = true;
    };
    displayManager.gdm.enable = true;
    gnome = {
      gnome-keyring.enable = true;
      core-apps.enable = true;
    };
  };

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
  programs.dconf.enable = true;

  # Remove unwanted GNOME applications
  #environment.gnome.excludePackages = with pkgs; [
    #baobab      # disk usage analyzer
    #cheese      # photo booth
    #eog         # image viewer
    #epiphany    # web browser
    #simple-scan # document scanner
    #totem       # video player
    #yelp        # help viewer
    #evince      # document viewer
    #file-roller # archive manager
    #geary       # email client
    #seahorse    # password manager
    #gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    #gnome-font-viewer gnome-logs gnome-maps gnome-music gnome-screenshot
    #gnome-system-monitor gnome-weather gnome-disk-utility pkgs.gnome-connections
  #];

  # Minimal essential packages
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    home-manager
    lazygit
    asciiquarium
    neovim
    kitty
    phosh-mobile-settings
  ];

} 
