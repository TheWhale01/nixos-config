{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.slskd = {
    enable = true;
    group = "media";
    domain = null;
    environmentFile = config.age.secrets.soulseek.path;
    settings = {
      shares.directories = [ "/data/Music" ];
      directories.downloads = "/data/downloads/lidarr";
    };
  };
  users.users.slskd.extraGroups = [ "media" ];
  systemd.services.slskd.serviceConfig.UMask = "0002";
  services.traefik.dynamicConfigOptions.http = {
    services.soulseek.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString config.services.slskd.settings.web.port}";
      }
    ];
    routers.soulseek = {
      rule = "Host(`soulseek.${traefik-vars.domain}`)";
      tls = true;
      service = "soulseek";
      entrypoints = "websecure";
    };
  };
}
