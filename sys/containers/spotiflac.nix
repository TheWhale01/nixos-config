{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 6890;
in
{
  virtualisation.oci-containers.containers.spotiflac = {
    image = "ghcr.io/methammer/spotiflac:latest";
    volumes = [
      "/data/Music:/home/nonroot/Music"
      "/var/lib/spotiflac:/home/nonroot/.SpotiFLAC"
    ];
    environmentFiles = [ config.age.secrets.spotiflac.path ];
    extraOptions = [ "--network=container:proton" ];
  };
  systemd.services."podman-spotiflac" = {
    after = [ "podman-proton.service" ];
    requires = [ "podman-proton.service" ];
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
