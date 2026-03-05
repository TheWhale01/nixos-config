{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.bazarr = {
    enable = true;
    group = "media";
  };
  services.traefik.dynamicConfigOptions.http = {
    services.bazarr.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.bazarr.listenPort}";
    }];
    routers = {
      bazarr = {
        rule = "Host(`bazarr.${traefik-vars.domain}`)";
        tls = true;
        service = "bazarr";
        entrypoints = "websecure";
        middlewares = [ "bazarr-auth" ];
        priority = 10;
      };
      bazarr-auth = {
        rule = "Host(`bazarr.${traefik-vars.domain}`) && PathPrefix(`/outpost.goauthentik.io/`)";
        tls = true;
        service = "authentik-proxy";
        entrypoints = "websecure";
        priority = 15;
      };
    };
    middlewares.bazarr-auth = {
      forwardAuth = {
        address = "http://${config.services.authentik-proxy.listenHTTP}/outpost.goauthentik.io/auth/traefik";
        trustForwardHeader = true;
        authResponseHeaders = [ "X-authentik-username" "X-authentik-groups" "X-authentik-entitlements" "X-authentik-email" "X-authentik-name" "X-authentik-uid" "X-authentik-jwt" "X-authentik-meta-jwks" "X-authentik-meta-outpost" "X-authentik-meta-provider" "X-authentik-meta-app" "X-authentik-meta-version" "Authorization" ];
      };
    };
  };
}
