{ pkgs, config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  systemd.services.init-aurral-network = {
    description = "Create aurral-network for podman";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${pkgs.podman}/bin/podman network create aurral-network || true
    '';
    wantedBy = [ "mult-user.target" ];
    before = [
      "podman-aurral-backend.service"
      "podman-aurral-frontend.service"
    ];
  };
  virtualisation.oci-containers.containers."backend" = {
    image = "ghcr.io/lklynet/aurral-backend:latest";
    serviceName = "podman-aurral-backend";
    volumes = [
      "/var/lib/aurral/backend:/app/data"
    ];
    ports = [ "3001:3001" ];
    environmentFiles = [
      config.age.secrets.aurral.path
    ];
    extraOptions = [
      "--network=aurral-network"
      "--security-opt=no-new-privileges"
      "--cap-drop=ALL"
      "--cap-add=SETUID"
      "--cap-add=SETGID"
      "--cap-add=CHOWN"
    ];
  };
  virtualisation.oci-containers.containers."frontend" = {
    image = "ghcr.io/lklynet/aurral-frontend:latest";
    serviceName = "podman-aurral-frontend";
    volumes = [
      "/var/lib/aurral/frontend:/app/data"
    ];
    ports = [ "3002:80" ];
    dependsOn = [ "backend" ];
    extraOptions = [
      "--network=aurral-network"
      "--security-opt=no-new-privileges"
      "--cap-drop=ALL"
      "--cap-add=CHOWN"
      "--cap-add=SETUID"
      "--cap-add=SETGID"
      "--cap-add=NET_BIND_SERVICE"
    ];
  };
  services.traefik.dynamicConfigOptions.http = {
    services.aurral.loadBalancer.servers = [{
      url = "http://127.0.0.1:3002";
    }];
    routers.aurral = {
      rule = "Host(`aurral.${traefik-vars.domain}`)";
      tls = true;
      service = "aurral";
      entrypoints = "websecure";
    };
  };
}
