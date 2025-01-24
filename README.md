# nix-config

My attempt to create and maintain NixOS configuraiton files

Where I store them : `~/sources/nix-config`

what I do to deploy them (not tested) :
- On NixOS : `nix run nixpkgs#topgrade --config ~/sources/nix-config/packages/topgrade/topgrade.toml`
- other : need to install Topgrade first : `topgrade --config ~/sources/package/topgrade/topgrade.toml`

# TODO
![[TODO.md]]

See also my [home-manager config](https://github.com/Poaclu/home-manager)
