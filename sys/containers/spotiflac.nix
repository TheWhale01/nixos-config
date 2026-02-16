{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  virtualisation.oci-containers.containers.spotiflac = {
    image = "ghcr.io/notlugozzi/spotiflac-web:main";
    ports = [ "8083:8080" ];
    environment = {
      APP_NAME = "Spotiflac web";
      APP_ENV = "production";
      DEBUG = "false";
      SECRET_KEY = "";
      MUSIC_LIBRARY_PATH = "/music";
      DOWNLOAD_PATH = "/downloads";
      SPOTIFLAC_SERVICE = "tidal,qobuz,deezer";
      SPOTIFLAC_FILENAME_FORMAT = "{artist}/{album}/{track_number} - {title}";
      SCAN_INTERVAL = "60";
      AUTO_SCAN_ON_STARTUP = "true";
      LOG_LEVEL = "info";
    };
    environmentFiles = [ config.age.secrets.spotiflac.path ];
    volumes = [
      "/data/Music:/music"
      "/data/downloads/lidarr:/downloads"
      "/var/lib/spotiflac:/app/data"
    ];
  };
}
