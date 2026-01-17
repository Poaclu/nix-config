{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./system-config.nix
  ];

  poaclu = {
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
    swap.size = 16;
  };
  networking.hostName = "killi";
}
