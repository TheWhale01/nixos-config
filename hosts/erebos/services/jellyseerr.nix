{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.jellyseerr = {
    enable = true;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.jellyseerr.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.jellyseerr.port}";
    }];
    routers.jellyseerr = {
      rule = "Host(`jellyseerr.${traefik-vars.domain}`)";
      tls = true;
      service = "jellyseerr";
      entrypoints = "websecure";
    };
  };
}
