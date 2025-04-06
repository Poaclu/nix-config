{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    desktop.xdg = lib.mkEnableOption "Enable XDG environment";
  };

  config = lib.mkIf config.desktop.xdg {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
      ];
      config = {
        common.default = "wlr";
      };
      wlr.enable = true;
    };

    environment.systemPackages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };
}
