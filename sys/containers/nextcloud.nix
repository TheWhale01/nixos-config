{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  virtualisation.oci-containers.containers.nextcloud = {
    image = "nextcloud";
    volumes = [
      "/data/nextcloud:/var/www/html"
    ];
    ports = [ "8881:80" ];
    environmentFiles = [ config.age.secrets.nextcloud.path ];
  };
  virtualisation.oci-containers.containers."nextcloud-office" = {
    image = "collabora/code";
    capabilities = {
      MKNOD = true;
    };
    ports = [ "9980:9980" ];
    environment = {
      aliasgroup1 = "https://nextcloud.${traefik-vars.domain}:443";
      extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.nextcloud.loadBalancer.servers = [{
        url = "http://127.0.0.1:8881";
    }];
    services.nextcloud-office.loadBalancer.servers = [{
        url = "http://127.0.0.1:9980";
    }];
    routers.nextcloud = {
      rule = "Host(`nextcloud.${traefik-vars.domain}`)";
      tls = true;
      service = "nextcloud";
      entrypoints = "websecure";
    };
    routers.nextcloud-office = {
      rule = "Host(`nextcloud-office.${traefik-vars.domain}`)";
      tls = true;
      service = "nextcloud-office";
      entrypoints = "websecure";
    };
  };
}
