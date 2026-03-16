{ config, ... }:

{
  virtualisation.oci-containers.containers."proton" = {
    image = "qmcgaw/gluetun:latest";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--cap-add=NET_RAW"
      "--device=/dev/net/tun:/dev/net/tun"
    ];
    ports = [
      "9091:9091"
    ];
    environmentFiles = [ config.age.secrets.proton-wg.path ];
    volumes = [
      "/var/lib/gluetun:/gluetun"
    ];
  };
}
