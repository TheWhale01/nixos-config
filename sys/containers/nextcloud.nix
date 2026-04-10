{ config, ... }:

let
  vars = import ../vars.nix;
in
{
  virtualisation.oci-containers.containers.nextcloud = {
    image = "nextcloud";
    volumes = [
      "/data/nextcloud:/var/www/html"
    ];
    ports = [ "${toString vars.nextcloud.port}:80" ];
    environmentFiles = [ config.age.secrets.nextcloud.path ];
  };
  virtualisation.oci-containers.containers."nextcloud-office" = {
    image = "collabora/code";
    capabilities = {
      MKNOD = true;
    };
    ports = [ "${toString vars.nextcloud.office.port}:9980" ];
    environment = {
      aliasgroup1 = "https://nextcloud.${vars.traefik.domain}:443";
      extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.nextcloud.loadBalancer.servers = [{
        url = "http://127.0.0.1:${toString vars.nextcloud.port}";
    }];
    services.nextcloud-office.loadBalancer.servers = [{
        url = "http://127.0.0.1:${toString vars.nextcloud.office.port}";
    }];
    routers.nextcloud = {
      rule = "Host(`nextcloud.${vars.traefik.domain}`)";
      tls = true;
      service = "nextcloud";
      entrypoints = "websecure";
    };
    routers.nextcloud-office = {
      rule = "Host(`nextcloud-office.${vars.traefik.domain}`)";
      tls = true;
      service = "nextcloud-office";
      entrypoints = "websecure";
    };
  };
}
