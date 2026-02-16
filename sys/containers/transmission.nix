{ pkgs, config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  virtualisation.oci-containers.containers.transmission = {
    image = "lscr.io/linuxserver/transmission:latest";
    extraOptions = [ "--network=container:proton" ];
    volumes = [
      "/var/lib/transmission:/config"
      "/data:/data"
      "/tmp/proton:/shared"
    ];
    environmentFiles = [ config.age.secrets.transmission.path ];
    environment = {
      PUID = "1000";
      PGID = "982";
      TZ = "Europe/Paris";
      LOG_LEVEL = "debug";
      PEERPORT = "63913";
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.transmission.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:9091";
      }
    ];
    routers.transmission = {
      rule = "Host(`transmission.${traefik-vars.domain}`)";
      tls = true;
      service = "transmission";
      entrypoints = "websecure";
    };
  };
  systemd.services."podman-transmission" = {
    after = [ "podman-proton.service" ];
    requires = [ "podman-proton.service" ];
  };
}
