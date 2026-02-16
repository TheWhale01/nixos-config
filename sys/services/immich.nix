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
      # middlewares = "immich-upload-size";
    };
    # middlewares.immich-upload-size = {
    #   buffering = {
    #     maxRequestBodyBytes = 0;
    #     maxResponseBodyBytes = 0;
    #     memRequestBodyBytes = 20971520;
    #     memResponseBodyBytes = 20971520;
    #     retryExpression = "IsNetworkError() && Attempts() < 2";
    #   };
    # };
  };
}
