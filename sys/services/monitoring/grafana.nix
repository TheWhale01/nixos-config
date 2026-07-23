{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
in
{
  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3000;
        enforce_domain = true;
        enable_gzip = true;
        domain = "grafana.${vars.traefik.domain}";
        root_url = "https://${config.services.grafana.settings.server.domain}";
      };
      analytics.reporting_enabled = false;
      security.secret_key = config.age.secrets.grafana-secret.path;
    };
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://127.0.0.1:${toString config.services.prometheus.port}";
          uid = "${vars.prometheus.uid}";
          isDefault = true;
        }
        {
          name = "Loki";
          type = "loki";
          url = "http://${config.services.loki.configuration.common.instance_addr}:${toString config.services.loki.configuration.server.http_listen_port}";
        }
      ];
    };
  };
  systemd.services.grafana.serviceConfig.EnvironmentFile = [
    config.age.secrets.grafana.path
  ];
  services.traefik.dynamicConfigOptions.http = {
    services.grafana.loadBalancer.servers = [{
      url = "http://${config.services.grafana.settings.server.http_addr}:${toString config.services.grafana.settings.server.http_port}";
    }];
    routers.grafana = {
      rule = "Host(`grafana.${vars.traefik.domain}`)";
      tls = true;
      service = "grafana";
      entrypoints = "websecure";
    };
  };
}
