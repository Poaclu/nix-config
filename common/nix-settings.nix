{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      download-buffer-size = 500000000; # 500 MB
      trusted-users = [
        "poaclu"
        "root"
        "@wheel"
      ];
      substituters = [
        "https://cache.nixos.org/"
        "https://cachix.cachix.org"
        "https://hyprland.cachix.org"
        "https://nixpkgs.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [
        "https://cache.nixos.org/"
        "https://cachix.cachix.org"
        "https://hyprland.cachix.org"
        "https://nixpkgs.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs.cachix.org-1:q91R6hxbwFvDqTSDKwDAV4T5PxqXGxswD8vhONFMeOE="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nixpkgs.config = {
      allowUnfree = true;
  };
}
