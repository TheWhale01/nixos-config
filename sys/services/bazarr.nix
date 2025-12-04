{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.bazarr = {
    enable = true;

  };
  services.traefik.dynamicConfigOptions.http = {
    services.bazarr.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString config.services.bazarr.listenPort}";
      }
    ];
    routers.bazarr = {
      rule = "Host(`bazarr.${traefik-vars.domain}`)";
      tls = true;
      service = "bazarr";
      entrypoints = "websecure";
    };
  };
}
