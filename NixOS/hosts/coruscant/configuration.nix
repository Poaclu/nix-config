{
  pkgs,
  ...
}:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./system-config.nix
  ];

  poaclu = {
    desktop.enable = false;
  };
  networking.hostName = "coruscant";
  environment.systemPackages = [ pkgs.kitty.terminfo ];
}
