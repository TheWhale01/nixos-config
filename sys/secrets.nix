{ config, ... }:

{
  age = {
    secrets = {
      spotiflac = {
        file = ../secrets/spotiflac.age;
      };
      soulseek = {
        file = ../secrets/soulseek.age;
      };
      lumiere = {
        file = ../secrets/lumiere.age;
        owner = "${config.services.lumiere.user}";
        group = "${config.services.lumiere.group}";
      };
      transmission = {
        file = ../secrets/transmission.age;
      };
      traefikCfDnsToken = {
        file = ../secrets/traefik/cf_dns_token.age;
        owner = "${config.services.traefik.group}";
        group = "${config.services.traefik.group}";
      };
      proton-wg.file = ../secrets/proton-wg.age;
      nextcloudAdminPass.file = ../secrets/nextcloud.age;
      litellm.file = ../secrets/litellm.age;
      homepageJellyfin.file = ../secrets/homepage/jellyfin.age;
      homepageJellyseerr.file = ../secrets/homepage/jellyseerr.age;
      homepageRadarr.file = ../secrets/homepage/radarr.age;
      homepageSonarr.file = ../secrets/homepage/sonarr.age;
      homepageBazarr.file = ../secrets/homepage/bazarr.age;
      homepageProwlarr.file = ../secrets/homepage/prowlarr.age;
      homepageTransmission.file = ../secrets/homepage/transmission.age;
      homepageNextcloud.file = ../secrets/homepage/nextcloud.age;
      homepageImmich.file = ../secrets/homepage/immich.age;
      aurral.file = ../secrets/aurral.age;
    };
  };
}
