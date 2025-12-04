{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.radarr = {
    enable = true;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.radarr.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString config.services.radarr.settings.server.port}";
      }
    ];
    routers.radarr = {
      rule = "Host(`radarr.${traefik-vars.domain}`)";
      tls = true;
      service = "radarr";
      entrypoints = "websecure";
    };
  };
}
