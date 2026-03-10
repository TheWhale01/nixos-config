{ config, pkgs, ... }:

let
  traefik-vars = (import ../../vars.nix).traefik;
  dashboards = (import ./dashboards { inherit pkgs; }).dashboards;
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
        domain = "grafana.${traefik-vars.domain}";
        root_url = "https://${config.services.grafana.settings.server.domain}";
      };
      analytics.reporting_enabled = false;
    };
    provision = {
      enable = true;
      datasources.settings.datasources = [
        {
          name = "Prometheus";
          type = "prometheus";
          url = "http://127.0.0.1:${toString config.services.prometheus.port}";
          isDefault = true;
        }
      ];
      dashboards.settings.providers = [
        {
          name = "NixOS Declarative dashboards";
          options.path = dashboards;
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
      rule = "Host(`grafana.${traefik-vars.domain}`)";
      tls = true;
      service = "grafana";
      entrypoints = "websecure";
    };
  };
}
