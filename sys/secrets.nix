{ config, ... }:

{
  age = {
    secrets = {
      grafana = {
        file = ../secrets/grafana.age;
        owner = "grafana";
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
      nextcloudAdminPass.file = ../secrets/nextcloud.age;
    };
  };
}
