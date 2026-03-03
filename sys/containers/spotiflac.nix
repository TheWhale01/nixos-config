{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  # virtualisation.oci-containers.containers.spotiflac = {
  #   image = "ghcr.io/notlugozzi/spotiflac-web:main";
  #   ports = [ "8083:8080" ];
  #   environment = {
  #     APP_NAME = "Spotiflac web";
  #     APP_ENV = "production";
  #     DEBUG = "false";
  #     SECRET_KEY = "1234";
  #     MUSIC_LIBRARY_PATH = "/music";
  #     DOWNLOAD_PATH = "/downloads";
  #     SPOTIFLAC_SERVICE = "tidal,qobuz,deezer";
  #     SPOTIFLAC_FILENAME_FORMAT = "{artist}/{album}/{track_number} - {title}";
  #     SCAN_INTERVAL = "60";
  #     AUTO_SCAN_ON_STARTUP = "true";
  #     LOG_LEVEL = "info";
  #   };
  #   environmentFiles = [ config.age.secrets.spotiflac.path ];
  #   volumes = [
  #     "/data/Music:/music"
  #     "/data/Music:/downloads"
  #     "/var/lib/spotiflac/data:/app/data"
  #   ];
  # };
  virtualisation.oci-containers.containers.spotiflac = {
    image = "ghcr.io/iassis/spotiflac:latest";
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Paris";
    };
    volumes = [
      "/var/lib/spotiflac:/config"
      "/data/Music:/downloads"
    ];
    ports = [ "8083:3001" ];
    extraOptions = [ "--shm-size" "1gb" "--security-opt" "seccomp=unconfined" ];
  };
}
