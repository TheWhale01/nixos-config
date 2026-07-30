{ config, vars, ... }:

{
  virtualisation.oci-containers.containers."proton" = {
    image = "qmcgaw/gluetun:latest";
    extraOptions = [
      "--cap-add=NET_ADMIN"
      "--cap-add=NET_RAW"
      "--device=/dev/net/tun:/dev/net/tun"
    ];
    ports = [
      "${toString vars.transmission.flood.port}:3001" # FLOOD
      "${toString vars.transmission.port}:9091" # TRANSMISSION
    ];
    environment = {
      DOT = "off";
      DNS_ADDRESS = "1.1.1.1";
      WIREGUARD_MTU = "1360";
      VPN_PORT_FORWARDING_UP_COMMAND = ''
        /bin/sh -c 'command -v transmission-remote >/dev/null 2>&1 || (apk update && apk add transmission-remote); transmission-remote localhost:9091 -n "$USER:$PASS" -p {{PORT}}'
      '';
    };
    environmentFiles = [
      config.age.secrets.proton-wg.path
      config.age.secrets.transmission.path
    ];
    volumes = [
      "/var/lib/gluetun:/gluetun"
    ];
  };
}
