{ config, ... }:

let
  vars = import ../vars.nix;
in
{
  services.cleanerr = {
    enable = true;
    downloadDir = "/data/downloads";
    transmissionUrl = "http://127.0.0.1:${toString vars.transmission.port}";
    environmentFile = config.age.secrets.transmission.path;
    group = "media";
    ignoredDirectories = [
      "readarr"
    ];
  };
}
