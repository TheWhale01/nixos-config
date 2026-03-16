{ config, ... }:

{
  virtualisation.oci-containers.containers.music-grabber = {
    image = "g33kphr33k/musicgrabber:latest";
    ports = [ "38274:8080" ];
    volumes = [
      "/data/Music:/music"
      "/var/lib/music-grabber:/data"
    ];
    environment = {
      MUSIC_DIR = "/music";
      DB_PATH = "/data/music_grabber.db";
      ENABLE_MUSICBRAINZ = "true";
      DEFAULT_CONVERT_TO_FLAC = "true";
      # JELLYFIN_URL = "http://192.168.1.154:8096";
      # JELLYFIN_API_KEY = "";
    };
    environmentFiles = [ config.age.secrets.music-grabber.path ];
  };
}
