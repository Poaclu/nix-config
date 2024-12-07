# nix-config

My attempt to create and maintain NixOS configuraiton files

Where I store them : `~/sources/nix-config`

what I do to deploy them (not tested) :
- On NixOS : `nix run nixpkgs#topgrade --config ~/source/nix-config/packages/topgrade/topgrade.toml`
- other : need to install Topgrade first : `topgrade --config ~/source/package/topgrade/topgrade.toml`
