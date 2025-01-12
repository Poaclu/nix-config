{ pkgs, lib, ... }: {

  imports = [
    ./gc.nix
    ./nixpkgs.nix
    ./nix.nix
  ];
}
