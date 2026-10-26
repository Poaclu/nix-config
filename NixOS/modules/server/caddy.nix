{ config, lib, pkgs, ... }:
let
  cfg = config.poaclu.server.caddy;
  domain = "poaclu.net";

  proxy = target: ''
    reverse_proxy ${target} {
      header_up Host {host}
      header_up X-Real-IP {remote_host}
      header_up X-Forwarded-Port {server_port}
    }
  '';

  hosts = {
    blog        = "nomex:8084";
    wizarr      = "nomex:5690";
    req         = "nomex:5056";
    vault       = "nomex:8003";
    bookorbit   = "nomex:3002";
    sso         = "nomex:9000";
    termix      = "kevlar:9000";
    radarr      = "nomex:9000";
    radarr4k    = "nomex:9000";
    sonarr      = "nomex:9000";
    sonarr4k    = "nomex:9000";
    profilarr   = "nomex:9000";
    cleanuparr  = "nomex:9000";
    bazarr      = "nomex:9000";
    dockhand    = "nomex:9000";
    portainer   = "portainer:9000"; 
    home        = "nomex:7575";
    beszel      = "nomex:8091";
    tools       = "nomex:8090";
    status      = "kevlar:3001";
  };

  mkHandle = name: target: ''
    @${name} host ${name}.${domain}
    handle @${name} {
      ${proxy target}
    }
  '';
in
{
  options.poaclu.server.caddy = {
    enable = lib.mkOption {
      description = "Caddy reverse proxy with Cloudflare DNS challenge and CrowdSec";
      type = lib.types.bool;
      default = false;
      example = true;
    };
  };
  config = lib.mkIf cfg.enable {
    services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.4"
        "github.com/hslatman/caddy-crowdsec-bouncer@v0.14.1"
      ];
      hash = "sha256-txqfhL9rm5DgEmFUIqQdcf9xm3x9tcNHxzU01xSrQGM=";
    };

    environmentFile = config.age.secrets.caddy-env.path;

    globalConfig = ''
      email {env.ACME_EMAIL}
      acme_ca https://acme.zerossl.com/v2/DV90
      acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}

      order crowdsec first
      order appsec first

      crowdsec {
        api_url http://nomex:6800
        api_key {env.CADDY_BOUNCER}
        ticker_interval 15s
        appsec_url http://nomex:7422
      }
    '';

    extraConfig = ''
      (common) {
        crowdsec
        appsec
        encode gzip

        tls {
          dns cloudflare {env.CLOUDFLARE_API_TOKEN}
          key_type rsa2048
          resolvers 1.1.1.1
          propagation_timeout 3m
        }

        header {
          Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
          X-Content-Type-Options "nosniff"
          X-Frame-Options "SAMEORIGIN"
          Content-Security-Policy "frame-ancestors 'self';"
          Referrer-Policy "no-referrer"
        }
      }

      *.${domain} {
        import common

        @wizarr2 {
          host stream.${domain}
          path /j/* /i/* /static/* /wizard/* /invitation/*
        }
        handle @wizarr2 {
          ${proxy "nomex:5690"}
        }

        ${mkHandle "stream" "nomex:8096"}
        ${lib.concatStringsSep "\n" (lib.mapAttrsToList mkHandle hosts)}

        respond 404
      }

      ${domain} {
        redir https://home.${domain} 308
      }

      poac.lu {
        import common

        handle /beta/* {
          ${proxy "nomex:9000"}
        }

        ${proxy "nomex:8084"}
      }
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPorts = [ 443 ]; # QUIC
  };
  };
}
