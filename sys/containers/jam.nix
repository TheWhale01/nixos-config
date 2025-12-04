{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 8056;
in
{
  virtualisation.oci-containers.containers."jam" = {
    image = "hrfee/jfa-go";
    volumes = [
      "/var/lib/jam:/data"
      "${config.services.jellyfin.dataDir}:/jf"
      "/etc/zoneinfo/Europe/Paris:/etc/localtime:ro"
    ];
    extraOptions = [ "--network=host" ];
  };
  services.traefik.dynamicConfigOptions.http = {
    services.jam.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString port}";
      }
    ];
    routers.jam = {
      rule = "Host(`jam.${traefik-vars.domain}`)";
      tls = true;
      service = "jam";
      entrypoints = "websecure";
    };
  };
}
