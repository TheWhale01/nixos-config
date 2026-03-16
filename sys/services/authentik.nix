{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 9000;
in
{
  services.authentik = {
    enable = true;
    environmentFile = config.age.secrets.authentik.path;
    settings = {
      disable_startup_analytics = true;
      avatars = "initials";
      listen.ldap = "127.0.0.1:389";
      listen.ldaps = "127.0.0.1:636";
    };
  };
  services.authentik-ldap = {
    enable = true;
    environmentFile = config.age.secrets.authentik-ldap.path;
  };
  services.authentik-proxy = {
    enable = true;
    listenMetrics = "127.0.0.1:9303";
    listenHTTPS = "127.0.0.1:9004";
    listenHTTP = "127.0.0.1:9005";
    environmentFile = config.age.secrets.authentik-proxy.path;
  };
  systemd.services.authentik-ldap = {
    serviceConfig = {
      AmbientCapabilities = [ "CAP_NET_BIND_SERVICE" ];
      CapabilityBoundingSet = [ "CAP_NET_BIND_SERVICE" ];
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.authentik.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers.authentik = {
      rule = "Host(`authentik.${traefik-vars.domain}`)";
      tls = true;
      service = "authentik";
      entrypoints = "websecure";
    };
  };
}
