{ config, ... }:

{
  services.cleanerr = {
    enable = true;
    downloadDir = "/data/downloads";
    transmissionUrl = "http://127.0.0.1:9091";
    environmentFile = config.age.secrets.transmission.path;
    group = "media";
  };
}
