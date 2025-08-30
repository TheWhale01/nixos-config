{ ... }:

{
  virtualisation.oci-containers.containers."satiserver" = {
    image = "wolveix/satisfactory-server:latest";
    volumes = [
      "/var/lib/satiserver:/config"
    ];
    hostname = "erebos-factory";
    environment = {
      MAX_PLAYERS = "5";
      PGID = "1000";
      PUID = "1000";
      STEAMBETA = "false";
    };
    extraOptions = [ "--memory-reservation=4G" "--memory" "8G" "--network=host" ];
  };
}
