{ config, ... }:

{
  age = {
    secrets = {
      soulseek = {
        file = ../secrets/soulseek.age;
        # owner = "${config.services.slskd.user}";
        # group = "${config.services.slskd.group}";
      };
      lumiere = {
        file = ../secrets/lumiere.age;
        owner = "${config.services.lumiere.user}";
        group = "${config.services.lumiere.group}";
      };
      transmission = {
        file = ../secrets/transmission.age;
        owner = "${config.services.transmission.user}";
        group = "${config.services.transmission.group}";
      };
      traefikCfDnsToken = {
        file = ../secrets/traefik/cf_dns_token.age;
        owner = "${config.services.traefik.group}";
        group = "${config.services.traefik.group}";
      };
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
      aurral.file = ../secrets/aurral.age;
    };
  };
}
