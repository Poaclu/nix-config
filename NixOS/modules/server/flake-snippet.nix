# flake.nix — snippet d'intégration pour ton VPS
# À fusionner dans ton flake existant

{
  description = "NixOS config — VPS poaclu.net";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # ou nixos-24.11
  };

  outputs = { self, nixpkgs, ... }: {

    nixosConfigurations = {

      # Nom de ton VPS — à adapter
      vps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hardware-configuration.nix  # généré par nixos-generate-config
          ./configuration.nix           # config système de base

          # Modules HAProxy + ACME + nginx
          ./modules/acme.nix
          ./modules/haproxy.nix
          ./modules/nginx.nix
        ];
      };

    };
  };
}

# ─────────────────────────────────────────────────────────────
# DÉPLOIEMENT
# ─────────────────────────────────────────────────────────────
#
# Depuis ta machine locale (avec Tailscale ou accès SSH direct) :
#
#   nixos-rebuild switch --flake .#vps --target-host root@<ip-vps> --build-host localhost
#
# Ou si tu veux builder sur le VPS directement :
#
#   nixos-rebuild switch --flake .#vps --target-host root@<ip-vps>
#
# ─────────────────────────────────────────────────────────────
# ORDRE DE BOOT (important pour ACME)
# ─────────────────────────────────────────────────────────────
#
# 1. nginx démarre → écoute sur 127.0.0.1:8080
# 2. ACME tente de valider le domaine via HTTP-01 challenge
#    → HAProxy doit être UP sur le port 80 pour router /.well-known/acme-challenge/
#    → NixOS gère ça automatiquement via le module ACME natif
# 3. Une fois le cert généré → HAProxy le charge sur le port 443
#
# Premier déploiement : le cert n'existe pas encore.
# HAProxy va échouer à démarrer si le fichier PEM est absent.
# Solution : commenter temporairement le bind *:443 dans haproxy.nix,
# déployer, laisser ACME générer le cert, puis ré-activer le bind HTTPS.
#
# ─────────────────────────────────────────────────────────────
# DÉPOSER LES FICHIERS DU SITE
# ─────────────────────────────────────────────────────────────
#
#   scp -r ./dist/* root@<ip-vps>:/var/www/blog.poaclu.net/
#
# Ou via rsync :
#
#   rsync -avz --delete ./dist/ root@<ip-vps>:/var/www/blog.poaclu.net/
#
# ─────────────────────────────────────────────────────────────
# VÉRIFICATIONS UTILES
# ─────────────────────────────────────────────────────────────
#
#   systemctl status haproxy nginx
#   journalctl -u haproxy -f
#   journalctl -u acme-blog.poaclu.net -f
#
#   # Stats HAProxy (via SSH tunnel) :
#   ssh -L 8404:127.0.0.1:8404 root@<ip-vps>
#   # puis ouvrir http://localhost:8404/stats
