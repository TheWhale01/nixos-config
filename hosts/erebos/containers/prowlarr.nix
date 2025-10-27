{ ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 9696;
in
{
  virtualisation.oci-containers.containers."prowlarr" = {
    image = "lscr.io/linuxserver/prowlarr:latest";
    volumes = [
      "/var/lib/prowlarr:/config"
    ];
    environment = {
      PGID = "1000";
      PUID = "1000";
      TZ = "Europe/Paris";
    };
    extraOptions = [ "--network=host" "--dns=1.1.1.1" ];
  };
  services.traefik.dynamicConfigOptions.http = {
    services.prowlarr.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers.prowlarr = {
      rule = "Host(`prowlarr.${traefik-vars.domain}`)";
      tls = true;
      service = "prowlarr";
      entrypoints = "websecure";
    };
  };
}
