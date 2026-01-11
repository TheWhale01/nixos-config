{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.sonarr = {
    enable = true;
    group = "media";
  };
  services.traefik.dynamicConfigOptions.http = {
    services.sonarr.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString config.services.sonarr.settings.server.port}";
      }
    ];
    routers.sonarr = {
      rule = "Host(`sonarr.${traefik-vars.domain}`)";
      tls = true;
      service = "sonarr";
      entrypoints = "websecure";
    };
  };
}
