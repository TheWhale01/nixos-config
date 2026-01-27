{ ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.traefik.dynamicConfigOptions.http = {
    services.translaitor.loadBalancer.servers = [{
      url = "http://127.0.0.1:3000";
    }];
    routers.translaitor = {
      rule = "Host(`translaitor.${traefik-vars.domain}`)";
      tls = true;
      service = "translaitor";
      entrypoints = "websecure";
    };
  };
}
