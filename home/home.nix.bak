{pkgs, ...}: let
  username = "poaclu";
in {
  imports = [
    ./packages
  ];
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";

    packages = with pkgs; [
      bat
      brave
      btop
      eza
      fastfetch
      obsidian
      starship
      xfce.thunar
      tldr
      topgrade
      zoxide
    ];
  };
}
