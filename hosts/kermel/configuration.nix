{
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.disko.nixosModules.default
    ./disko-config.nix
    ./hardware-configuration.nix
    ./system-config.nix
  ];

  boot = {
    grub.enable = false;
    lanza.enable = true;
  };
  desktop = {
    enable = true;
    xdg = true;
  };
  gaming.enable = true;
  networking.hostName = "kermel";
}
