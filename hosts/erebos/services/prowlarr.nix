{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.prowlarr = {
    enable = true;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.prowlarr.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.prowlarr.settings.server.port}";
    }];
    routers.prowlarr = {
      rule = "Host(`prowlarr.${traefik-vars.domain}`)";
      tls = true;
      service = "prowlarr";
      entrypoints = "websecure";
    };
  };
}
