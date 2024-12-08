# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  fileSystems."/etc/nixos" = {
    device = "/home/poaclu/sources/nix-config";
    options = [ "bind" ];
  };
  # Use the systemd-boot EFI boot loader.
  boot.loader = {
  	systemd-boot.enable = false;
	efi.canTouchEfiVariables = true;
	grub = {
		enable = true;
		efiSupport = true;
		devices = [ "nodev" ];
	};
  };

  swapDevices = [{
  	device = "/swapfile";
	size = 4 * 1024;
  }];

  systemd.user.services.xdg-desktop-portal-gtk = {
	wantedBy = [ "xdg-desktop-portal.service" ];
	before = [ "xdg-desktop-portal.service" ];
  };

  nix = {
  	settings.experimental-features = [ "nix-command" "flakes" ];
	gc = {
		automatic = true;
		dates = "monthly";
		persistent = true;
	};
  };

  security = {
    sudo = {
      enable = true;
      extraConfig = ''
        Cmnd_Alias	REBOOT = /sbin/halt, /sbin/reboot, /sbin/poweroff
	%wheel ALL=NOPASSWD: REBOOT
	Defaults rootpw
      '';
    };
    rtkit.enable = true;
  };

  networking = {
	hostName = "dragonfly"; # Define your hostname.
	networkmanager.enable = true;  # Easiest to use and most distros use this by default.
	enableIPv6 = false;
  };
  time.timeZone = "Europe/Paris";


  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";
  console = {
	keyMap = "fr";
  };

  # Enable the X11 windowing system.
  services = {
	picom.enable = true;
	pipewire  = {
		enable = true;
		alsa.enable =  true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};
	tailscale.enable = true;
	xserver = {
		enable = true;
		displayManager.lightdm.enable = true;
		xkb.layout = "fr";
		#xkb.options = "eurosign:e,caps:escape";
	};
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;
  
  xdg.portal = {
	enable = true;
	extraPortals = with pkgs; [
		xdg-desktop-portal-wlr
		xdg-desktop-portal-kde
		xdg-desktop-portal-gtk
    	];
    	wlr = {
      		enable = true;
      		settings = { # uninteresting for this problem, for completeness only
         		screencast = {
          			output_name = "eDP-1";
          			max_fps = 30;
          			chooser_type = "simple";
          			chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        		};
      		};
    	};
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.poaclu = {
	description = "Poaclu";
	isNormalUser = true;
    	shell = pkgs.zsh;
    	extraGroups = [ 
		"wheel"
		"networkmanager"
		"mlocate"
	];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	alacritty
	cliphist
	dunst
	libnotify
    	#firefox
	git
	grim
	hyprpaper
	home-manager
	kitty
	mlocate
    	neovim
	networkmanagerapplet
	rofi-wayland
	slurp
	swaylock
	swww
    	vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	warp-terminal
	(waybar.overrideAttrs (oldAttrs: {
	  mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	  })
	)
    	wofi
    	wget
  ];
  programs = {
    firefox.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh.enable = true;
  }; 

  nixpkgs.config = {
  	allowUnfree = true;
  	allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  		"warp-terminal"
  	];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system = {
  	stateVersion = "24.11"; # Did you read the comment?
	autoUpgrade = {
		enable = true;
		dates = "daily";
		operation = "boot";
		flake = inputs.self.outPath;
		flags = [
			"--flake ~/sources/nix-config/"
			"--update-input"
			"nixpkgs"
			"-L" # print build logs
		];
		persistent = true;
		rebootWindow = {
			lower = "01:00";
			upper = "05:00";
		};
	};
  };

}
