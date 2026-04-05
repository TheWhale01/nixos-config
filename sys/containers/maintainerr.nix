{ config, pkgs, ... }:

let
  port = 6246;
in
{
  virtualisation.oci-containers.containers = {
    maintainerr = {
      image = "ghcr.io/maintainerr/maintainerr:latest";
      volumes = [
        "/var/lib/maintainerr:/opt/data"
      ];
      environment = {
        TZ = "Europe/Paris";
      };
      user = "1000:100";
      ports = [ "${toString port}:${toString port}" ];
    };
  };
}
