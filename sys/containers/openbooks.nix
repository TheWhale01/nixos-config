{ ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 8081;
in
{
  virtualisation.oci-containers.containers."openbooks" = {
    image = "evanbuss/openbooks";
    volumes = [ "/data/Books:/books" ];
    ports = [ "${toString port}:80" ];
    cmd = [
      "--persist"
      "--name=openbooks"
    ];
    extraOptions = [ "--name=openbooks" ];
  };
  services.traefik.dynamicConfigOptions.http = {
    services.openbooks.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString port}";
      }
    ];
    routers.openbooks = {
      rule = "Host(`openbooks.${traefik-vars.domain}`)";
      tls = true;
      service = "openbooks";
      entrypoints = "websecure";
    };
  };
}
