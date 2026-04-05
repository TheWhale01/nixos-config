{ config, ... }:

{
  age = {
    secrets = {
      aurral.file = ../secrets/aurral.age;
      spotiflac.file = ../secrets/spotiflac.age;
      nextcloud.file = ../secrets/nextcloud.age;
      mas = {
        file = ../secrets/mas.age;
        owner = "mas";
        group = "mas";
        mode = "0400";
      };
      matrix = {
        file = ../secrets/matrix.age;
        owner = "matrix-synapse";
        group = "matrix-synapse";
        mode = "0400";
      };
      grafana = {
        file = ../secrets/grafana.age;
        owner = "grafana";
        mode = "0400";
      };
      homepage = {
        file = ../secrets/homepage.age;
      };
      vaultwarden = {
        file = ../secrets/vaultwarden.age;
      };
      authentik-proxy = {
        file = ../secrets/authentik/proxy.age;
      };
      authentik-ldap = {
        file = ../secrets/authentik/ldap.age;
      };
      authentik = {
        file = ../secrets/authentik/authentik.age;
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
    };
  };
}
