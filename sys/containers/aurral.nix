{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 3001;
in
{
  virtualisation.oci-containers.containers.aurral = {
    image = "ghcr.io/lklynet/aurral:latest";
    ports = [ "${toString port}:${toString port}" ];
    volumes = [
      "/data/downloads/lidarr:/downloads"
      "/var/lib/aurral:/app/backend/data"
    ];
    environment = {
      DOWNLOAD_FOLDER = "/downloads";
      PUID = "1000";
      PGID = "982";
      TRUST_PROXY = "1";
      AUTH_PROXY_ENABLED = "true";
      AUTH_PROXY_HEADER = "X-authentik-username";
      AUTH_PROXY_TRUSTED_IPS = "0.0.0.0/0";
      AUTH_PROXY_ADMIN_USERS = "whale";
      AUTH_PROXY_ROLE_HEADER = "X-authentik-groups";
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.aurral.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers = {
      aurral = {
        rule = "Host(`aurral.${traefik-vars.domain}`)";
        tls = true;
        service = "aurral";
        entrypoints = "websecure";
	middlewares = [ "aurral-auth" ];
        priority = 10;
      };
      aurral-auth = {
        rule = "Host(`aurral.${traefik-vars.domain}`) && PathPrefix(`/outpost.goauthentik.io/`)";
        tls = true;
        service = "authentik-proxy";
        entrypoints = "websecure";
        priority = 15;
      };
    };
    middlewares.aurral-auth = {
      forwardAuth = {
        address = "http://${config.services.authentik-proxy.listenHTTP}/outpost.goauthentik.io/auth/traefik";
        trustForwardHeader = true;
        authResponseHeaders = [ "X-authentik-username" "X-authentik-groups" "X-authentik-entitlements" "X-authentik-email" "X-authentik-name" "X-authentik-uid" "X-authentik-jwt" "X-authentik-meta-jwks" "X-authentik-meta-outpost" "X-authentik-meta-provider" "X-authentik-meta-app" "X-authentik-meta-version" "Authorization" ];
      };
    };
  };
}
