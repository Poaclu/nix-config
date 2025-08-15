{ config, pkgs, lib, ... }:
{ 
  options = {
    shell = {
      enable = lib.mkOption {
        description = "Enable Shell config for user config";
        type = lib.types.bool;
        default = true;
        example = false;
      };
    };
  };  
  config = lib.mkIf config.shell.enable {
    home = {
      stateVersion = "24.11"; # DO NOT CHANGE : The state version is required and should stay at the version you originally installed.
      packages = with pkgs; [
        bat
        eza
        fzf
        tldr
      ];
    };

    programs = {
      fastfetch.enable = true;
      starship = {
        enable = true;
        enableZshIntegration = true;
      };
      pay-respects = {
        enable = true;
        enableZshIntegration = true;
      };
      topgrade = {
        enable = true;
        settings = {
          misc = {
            sudo_command = "sudo";
            disable = [
              "node"
              "git_repos"
              "nix"
              "home_manager"
            ];
            set_title = false;
            display_time = true;
            assume_yes = false;
            notify_each_step = true;
          };
          commands = {
            home-manager = "home-manager switch --flake ~/.config/home-manager/";
          };
          linux = {
            nix_arguments = "--flake /etc/nixos/";
            nix_env_arguments = "--quiet --always --prebuilt-only";
          };
          firmware.upgrade = false;
        };
      };
      zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
      zsh = {
        enable = true;
        oh-my-zsh = {
          enable = true;
          plugins = [
            "aliases"
              "colored-man-pages"
              "fzf"
              "ufw"
              "zsh-interactive-cd"
          ];
        };
	initContent = "clear && fastfetch";
	sessionVariables = {
		VISUAL = "bat";
		EDITOR = "nvim";
	};
        shellAliases = {
          "-" = "cd -";
          ".." = "cd ..";
          "..." = "../..";
          "...." = "../../..";
          "....." = "../../../..";
          "......" = "../../../../..";
          "1" = "cd -1";
          "2" = "cd -2";
          "3" = "cd -3";
          "4" = "cd -4";
          "5" = "cd -5";
          "6" = "cd -6";
          "7" = "cd -7";
          "8" = "cd -8";
          "9" = "cd -9";
          _ = "sudo ";
          cargo = "RUSTC_WRAPPER=sccache cargo";
          cat = "bat";
          cd = "z";
          "cd.." = "cd ..";
          cls = "clear && fastfetch";
          cp = "cp -iv";
          edit-in-kitty = "kitten edit-in-kitty";
          egrep = "egrep --color=auto";
          fgrep = "fgrep --color=auto";
          globurl = "noglob urlglobber ";
          grep = "grep";
          gs = "git status";
          gd = "git diff";
          hackwow = "cmatrix | lolcat";
          history = "omz_history";
          ksh = "kitty +kitten ssh";
          l = "ls -lah";
          la = "ls -lAh";
          ll = "ls -lh";
          ln = "ln -rsf";
          ls = "exa -lah --color=always --group-directories-first --hyperlink";
          lsa = "ls -lah";
          md = "mkdir -p";
          mount = "sudo mount";
          mv = "mv -iv";
          update-home = "home-manager switch --flake ~/.config/home-manager/ -b bak || topgrade --only home_manager";
          update-nix = "sudo nixos-rebuild switch --flake /etc/nixos/ || topgrade --only system";
          upgrade-flake = "nix flake update --flake ~/sources/nix-config && nix flake update --flake ~/.config/home-manager && topgrade --only system home_manager";
          pacman = "sudo pacman";
          pdw = "pwd";
          poweroff = "sudo poweroff";
          rd = "rmdir";
          reboot = "sudo reboot";
          rm = "rm -virf";
          rr = "curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash";
          run-help = "man";
          shutdown = "sudo shutdown";
          sr = "sudo reboot";
          ssn = "sudo shutdown now";
          su = "sudo su";
          sv = "sudo sv";
          tree = "exa --tree --group-directories-first --hyperlink";
          umount = "sudo umount";
          update-fc = "sudo fc-cache -fv";
          update-grub = "sudo grub-mkconfig -o /boot/grub/grub.cfg";
          updatedb = "sudo updatedb";
          vim = "nvim";
          vimdiff = "nvim -d";
          wget = "wget -c";
          which-command = "whence";
        };
      };
    };
  };
}
