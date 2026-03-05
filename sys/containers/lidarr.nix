{ config, pkgs, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 8686;
in
{
  virtualisation.oci-containers.containers."lidarr" = {
    image = "ghcr.io/hotio/lidarr:pr-plugins";
    volumes = [
      "/var/lib/lidarr:/config"
      "/data:/data"
    ];
    environment = {
      PGID = "982";
      PUID = "1000";
      UMASK = "002";
    };
    extraOptions = [ "--network=host" ];
  };
  systemd.services."podman-lidarr".postStart = ''
    ${pkgs.podman}/bin/podman exec -it lidarr apk update
    ${pkgs.podman}/bin/podman exec -it lidarr apk add nodejs
  '';
  services.traefik.dynamicConfigOptions.http = {
    services.lidarr.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers = {
      lidarr = {
        rule = "Host(`lidarr.${traefik-vars.domain}`)";
        tls = true;
        service = "lidarr";
        entrypoints = "websecure";
        middlewares = [ "lidarr-auth" ];
        priority = 10;
      };
      lidarr-auth = {
        rule = "Host(`lidarr.${traefik-vars.domain}`) && PathPrefix(`/outpost.goauthentik.io/`)";
        tls = true;
        service = "authentik-proxy";
        entrypoints = "websecure";
        priority = 15;
      };
    };
    middlewares.lidarr-auth = {
      forwardAuth = {
        address = "http://${config.services.authentik-proxy.listenHTTP}/outpost.goauthentik.io/auth/traefik";
        trustForwardHeader = true;
        authResponseHeaders = [ "X-authentik-username" "X-authentik-groups" "X-authentik-entitlements" "X-authentik-email" "X-authentik-name" "X-authentik-uid" "X-authentik-jwt" "X-authentik-meta-jwks" "X-authentik-meta-outpost" "X-authentik-meta-provider" "X-authentik-meta-app" "X-authentik-meta-version" "Authorization" ];
      };
    };
  };
}
