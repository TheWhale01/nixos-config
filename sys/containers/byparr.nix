{ ... }:

{
  virtualisation.oci-containers.containers."byparr" = {
    image = "ghcr.io/thephaseless/byparr:latest";
    extraOptions = [ "--network=host" ];
  };
}
