{ config, lib, ... }:

{
  security.acme = {
    acceptTerms = true;

    defaults = {
      email = "certs@mail.poaclu.net"; # TODO: remplace par ton adresse
    };

    certs = {
      # TODO: remplacer "blog.poaclu.net" par "poac.lu" quand le domaine est prêt
      "blog.poaclu.net" = {
        # Domaines couverts par ce certificat
        extraDomainNames = [
          # "www.blog.poaclu.net"  # à activer si besoin
          # "poac.lu"              # TODO: décommenter quand poac.lu est dispo
          # "www.poac.lu"
        ];

        # HAProxy doit pouvoir lire les certs — on l'ajoute au groupe acme
        group = "haproxy";

        # Hook post-renouvellement : génère le PEM combiné pour HAProxy
        # HAProxy attend un seul fichier avec cert + key concaténés
        postRun = ''
          cat fullchain.pem key.pem > /var/lib/acme/blog.poaclu.net/haproxy.pem
          chmod 640 /var/lib/acme/blog.poaclu.net/haproxy.pem
        '';
        # TODO: quand poac.lu arrive, dupliquer ce bloc ou ajouter extraDomainNames
      };
    };
  };

  # HAProxy doit appartenir au groupe "acme" pour lire les certificats
  users.users.haproxy.extraGroups = [ "acme" ];
}
