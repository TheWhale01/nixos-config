{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.paperless = {
    enable = true;
    settings = {
      PAPERLESS_URL = "https://paperless.thewhale.fr";
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.paperless.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.paperless.port}";
    }];
    routers.paperless = {
      rule = "Host(`paperless.${traefik-vars.domain}`)";
      tls = true;
      service = "paperless";
      entrypoints = "websecure";
    };
  };
}
