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
    lanza = {
      enable = true;
      pkiBundle = "/var/lib/sbctl/";
    };
  };
  desktop = {
    enable = true;
    xdg = true;
  };
  gaming.enable = true;
  networking.hostName = "kermel";
}
