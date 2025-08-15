{ inputs, pkgs, ... }:
let
  zen = inputs.zen-browser.packages.${pkgs.system}.default;
in {
  programs.firefox = {
    enable = true;
    package = zen;                       # use Zen with the HM wrapper
    nativeMessagingHosts = [ pkgs.firefoxpwa ];

    profiles.default = {
      id = 0;
      name = "default";
      #extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        #privacy-badger
      #];
    };

    policies = {
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = { installation_mode = "force_installed"; };
        "bitwarden-password-manager@bitwarden.com" = { installation_mode = "allowed"; };
      };
    };
  };

  # Remove any Zen entry here. Let the module handle it.
  home.packages = [ ];
}
