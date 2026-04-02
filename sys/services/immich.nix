{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.immich = {
    enable = true;
    group = "media";
    host = "0.0.0.0";
    mediaLocation = "/data/Immich";
    settings = {
      newVersionCheck.enabled = true;
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.immich.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.immich.port}";
    }];
    routers.immich = {
      rule = "Host(`immich.${traefik-vars.domain}`)";
      tls = true;
      service = "immich";
      entrypoints = "websecure";
    };
  };
}
