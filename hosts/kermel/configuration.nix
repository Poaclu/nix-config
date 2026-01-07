{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix
    ./system-config.nix
  ];

  poaclu = {
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
    swap.size = 16;
  };
  networking.hostName = "kermel";
}
