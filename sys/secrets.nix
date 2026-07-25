{ config, ... }:

let
  vars = import ./vars.nix;
in
{
  age = {
    secrets = {
      authentik-terraform = {
        file = ../secrets/terraform/authentik.age;
        owner = "hades";
        group = "users";
        mode = "0400";
      };
      jellyfin-terraform = {
        file = ../secrets/terraform/jellyfin.age;
        owner = "hades";
        group = "users";
        mode = "0400";
      };
      grafana-terraform = {
        file = ../secrets/terraform/grafana.age;
        owner = "hades";
        group = "users";
        mode = "0400";
      };
      immich = {
        file = ../secrets/immich.age;
        owner = "${config.services.immich.user}";
        group = "${config.services.immich.group}";
        mode = "0400";
      };
      matrix-appservice = {
        file = ../secrets/matrix/appservice.age;
        owner = "${vars.matrix.user}";
        group = "${vars.matrix.group}";
        mode = "0400";
      };
      matrix-alertmanager-webhook.file = ../secrets/matrix/alertmanager-webhook.age;
      erebot.file = ../secrets/matrix/erebot.age;
      livekit.file = ../secrets/matrix/livekit.age;
      nextcloud.file = ../secrets/nextcloud.age;
      mas = {
        file = ../secrets/mas.age;
        owner = "${vars.mas.user}";
        group = "${vars.mas.group}";
        mode = "0400";
      };
      matrix = {
        file = ../secrets/matrix/matrix.age;
        owner = "${vars.matrix.user}";
        group = "${vars.matrix.group}";
        mode = "0400";
      };
      grafana = {
        file = ../secrets/grafana.age;
        owner = "grafana";
        mode = "0400";
      };
      grafana-secret = {
	file = ../secrets/grafana-secret.age;
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
