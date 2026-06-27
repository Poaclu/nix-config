# haproxy.nix
# Reverse proxy HAProxy avec :
#   - Redirection HTTP → HTTPS
#   - Terminaison TLS (Let's Encrypt)
#   - Backend nginx local (fichiers statiques)
#   - ACLs prêtes à étendre (routing par domaine, etc.)
# TODO: Ajouter le domaine poac.lu quand il est disponible

{ config, lib, pkgs, ... }:

{
  services.haproxy = {
    enable = true;

    config = ''
      #---------------------------------------------------------------------
      # GLOBAL
      #---------------------------------------------------------------------
      global
        log /dev/log local0
        log /dev/log local1 notice
        maxconn 4096
        user  haproxy
        group haproxy
        daemon

        # TLS moderne — désactive les vieilles versions
        ssl-default-bind-options ssl-min-ver TLSv1.2 no-tls-tickets
        ssl-default-bind-ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384
        ssl-default-bind-ciphersuites TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256

      #---------------------------------------------------------------------
      # DEFAULTS
      #---------------------------------------------------------------------
      defaults
        log     global
        mode    http
        option  httplog
        option  dontlognull
        option  forwardfor       # Passe l'IP réelle du client au backend
        option  http-server-close
        timeout connect  5s
        timeout client  30s
        timeout server  30s
        errorfile 400 /etc/haproxy/errors/400.http
        errorfile 403 /etc/haproxy/errors/403.http
        errorfile 408 /etc/haproxy/errors/408.http
        errorfile 500 /etc/haproxy/errors/500.http
        errorfile 502 /etc/haproxy/errors/502.http
        errorfile 503 /etc/haproxy/errors/503.http
        errorfile 504 /etc/haproxy/errors/504.http

      #---------------------------------------------------------------------
      # STATS (optionnel — accès à l'interface de monitoring HAProxy)
      # Accessible via SSH tunnel : ssh -L 8404:127.0.0.1:8404 user@vps
      #---------------------------------------------------------------------
      frontend stats
        bind 127.0.0.1:8404
        stats enable
        stats uri /stats
        stats refresh 10s
        stats auth admin:changeme   # TODO: changer ce mot de passe !

      #---------------------------------------------------------------------
      # FRONTEND HTTP — écoute sur le port 80, redirige tout vers HTTPS
      #---------------------------------------------------------------------
      frontend http_in
        bind *:80
        mode http

        # ACL : détecte le domaine pour le routing
        # TODO: ajouter poac.lu quand le domaine est prêt
        acl host_blog   hdr(host) -i blog.poaclu.net

        # Redirection permanente HTTP → HTTPS pour les domaines connus
        http-request redirect scheme https code 301 if host_blog

        # Fallback : tout le reste → 403
        http-request deny deny_status 403

      #---------------------------------------------------------------------
      # FRONTEND HTTPS — terminaison TLS, routing par ACL
      #---------------------------------------------------------------------
      frontend https_in
        # TODO: ajouter le cert de poac.lu quand dispo :
        #   crt /var/lib/acme/poac.lu/haproxy.pem
        bind *:443 ssl crt /var/lib/acme/blog.poaclu.net/haproxy.pem alpn h2,http/1.1

        mode http

        # Injecte l'en-tête HSTS (force HTTPS pour les navigateurs)
        http-response set-header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"

        # --- ACLs de routing ---
        # TODO: ajouter poac.lu quand le domaine est prêt
        acl host_blog   hdr(host) -i blog.poaclu.net
        # acl host_root   hdr(host) -i poac.lu www.poac.lu

        # --- Routing vers les backends ---
        use_backend backend_blog   if host_blog
        # use_backend backend_root   if host_root   # TODO: décommenter pour poac.lu

        # Fallback si aucun domaine ne correspond
        default_backend backend_blog

      #---------------------------------------------------------------------
      # BACKEND — nginx local qui sert les fichiers statiques
      #---------------------------------------------------------------------
      backend backend_blog
        mode http
        balance roundrobin   # utile si tu ajoutes plusieurs instances plus tard

        # Vérifie que nginx répond bien
        option httpchk GET /
        http-check expect status 200

        # nginx écoute en local sur le port 8080 (défini dans nginx.nix)
        server nginx_local 127.0.0.1:8080 check

        # --- Exemple load balancing (décommenter pour ajouter des backends) ---
        # server nginx_2 127.0.0.1:8081 check
        # server nginx_3 192.168.1.10:80 check

      # --- Backend futur pour poac.lu ---
      # backend backend_root
      #   mode http
      #   server nginx_local 127.0.0.1:8080 check
      #   # TODO: décommenter et adapter quand poac.lu est prêt
    '';
  };

  # Ouvre les ports dans le firewall
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
