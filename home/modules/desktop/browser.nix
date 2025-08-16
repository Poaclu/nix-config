{ config, inputs, pkgs, ... }:
let
  zen = inputs.zen-browser.packages.${pkgs.system}.default;
in {
  programs.firefox = {
    enable = true;
    package = zen;                       # use Zen with the HM wrapper
    languagePacks = [ "fr" "en-US" ];
    nativeMessagingHosts = [ pkgs.firefoxpwa ];

    profiles.default = {
      id = 0;
      name = "default";
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        auto-tab-discard
        darkreader
        french-language-pack
        kagi-search
        languagetool
        privacy-badger
        proton-pass
        sonarr-radarr-lidarr-search
        sponsorblock
        ublock-origin
      ];
    };

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = { installation_mode = "force_installed"; };
        "bitwarden-password-manager@bitwarden.com" = { installation_mode = "allowed"; };
      };
    };
  };

  # Remove any Zen entry here. Let the module handle it.
  home.packages = [ ];
}
