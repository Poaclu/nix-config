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

  bluetooth.enable = true;
  boot = {
    grub.enable = false;
    lanza = {
      enable = true;
      pkiBundle = "/etc/secureboot/";
    };
  };
  desktop = {
    enable = true;
    xdg = true;
  };
  gaming.enable = true;
  networking.hostName = "killi";
}
