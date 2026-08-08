{ config, vars, ... }:

{
  virtualisation.oci-containers.containers.gluetun = {
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
      VPN_SERVICE_PROVIDER = "protonvpn";
      VPN_TYPE = "wireguard";
      SERVER_COUNTRIES = "Netherlands,Switzerland";
      WIREGUARD_ADDRESSES = "10.2.0.2/32";
      VPN_PORT_FORWARDING = "on";
      VPN_PORT_FORWARDING_PROVIDER = "protonvpn";
      HEALTH_DURATION_INITIAL = "30s";
      SERVER_PORT_FORWARDING = "on";
    };
    environmentFiles = [
      config.age.secrets.gluetun.path
      config.age.secrets.transmission.path
    ];
    volumes = [
      "gluetun:/gluetun"
    ];
  };
}
