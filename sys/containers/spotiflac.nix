{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 6890;
in
{
  virtualisation.oci-containers.containers.spotiflac = {
    image = "ghcr.io/methammer/spotiflac:latest";
    ports = [ "${toString port}:${toString port}" ];
    volumes = [
      "/data/Music:/home/nonroot/Music"
      "/var/lib/spotiflac:/home/nonroot/.SpotiFLAC"
    ];
    environmentFiles = [ config.age.secrets.spotiflac.path ];
  };
  services.traefik.dynamicConfigOptions.http = {
    services.spotiflac.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers = {
      spotiflac = {
        rule = "Host(`spotiflac.${traefik-vars.domain}`)";
        tls = true;
        service = "spotiflac";
        entrypoints = "websecure";
        priority = 10;
      };
    };
  };
}
