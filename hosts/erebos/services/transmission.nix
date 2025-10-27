{ config, pkgs, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.transmission = {
    enable = true;
    performanceNetParameters = true;
    package = pkgs.transmission_4;
    group = "arr";
    webHome = pkgs.flood-for-transmission;
    settings = {
      rpc-enabled = true;
      rpc-bind-address = "0.0.0.0";
      rpc-authentication-required = true;
      rpc-whitelist-enabled = false;
      incomplete-dir-enabled = true;
      peer-port = 51413;
      encryption = 2;
      web-ui = "flood";
      utp-enabled = true;
      peer-port-random-on-start = true;
      peer-port-random-low = 49152;
      peer-port-random-high = 65535;
      download-dir = "/data/downloads";
    };
    credentialsFile = "${config.age.secrets.transmission.path}";
    downloadDirPermissions = "775";
    openRPCPort = true;
    openPeerPorts = true;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.transmission.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.transmission.settings.rpc-port}";
    }];
    routers.transmission = {
      rule = "Host(`transmission.${traefik-vars.domain}`)";
      tls = true;
      service = "transmission";
      entrypoints = "websecure";
    };
  };
}
