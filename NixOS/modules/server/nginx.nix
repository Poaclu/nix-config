# nginx.nix
# nginx en backend local — sert les fichiers statiques du site
# Il écoute UNIQUEMENT sur 127.0.0.1:8080 (pas exposé directement)
# C'est HAProxy qui gère l'exposition publique et le TLS

{ config, lib, ... }:

{
  services.nginx = {
    enable = true;

    # Désactive les logs d'accès verbeux (HAProxy loggue déjà)
    appendHttpConfig = ''
      access_log off;
    '';

    virtualHosts = {
      # TODO: renommer en "poac.lu" quand le domaine est prêt
      "blog.poaclu.net" = {
        # Écoute uniquement en local — HAProxy est le seul à y accéder
        listen = [
          { addr = "127.0.0.1"; port = 8080; }
        ];

        # Répertoire racine du site statique
        # Dépose tes fichiers HTML/CSS/JS ici
        root = "/var/www/blog.poaclu.net";  # TODO: adapter le chemin

        locations."/" = {
          tryFiles = "$uri $uri/ =404";
        };

        # Compression gzip pour les assets statiques
        extraConfig = ''
          gzip on;
          gzip_types text/plain text/css application/javascript application/json image/svg+xml;
          gzip_min_length 256;

          # En-têtes de cache pour les assets statiques
          location ~* \.(css|js|png|jpg|jpeg|gif|svg|ico|woff2?)$ {
            expires 30d;
            add_header Cache-Control "public, immutable";
          }
        '';
      };
    };
  };

  # Crée le répertoire du site s'il n'existe pas
  systemd.tmpfiles.rules = [
    "d /var/www/blog.poaclu.net 0755 nginx nginx -"  # TODO: adapter le chemin
  ];
}
