{ config, ... }:

{
  services.prometheus = {
    enable = true;
    port = 9090;
    listenAddress = "0.0.0.0";
    scrapeConfigs = [
      {
        job_name = "prometheus";
        scrape_interval = "5s";
        static_configs = [{
          targets = [ "${config.services.prometheus.listenAddress}:${toString config.services.prometheus.port}" ];
        }];
      }
      {
        job_name = "node_exporter";
        static_configs = [{
          targets = [ "${config.services.prometheus.exporters.node.listenAddress}:${toString config.services.prometheus.exporters.node.port}" ];
        }];
      }
      {
        job_name = "nvidia_gpu";
        static_configs = [{
          targets = [ "${config.services.prometheus.exporters.nvidia-gpu.listenAddress}:${toString config.services.prometheus.exporters.nvidia-gpu.port}" ];
        }];
      }
      {
        job_name = "authentik";
        static_configs = [{
          targets = [ "${config.services.authentik.settings.listen.metrics}" ];
        }];
      }
      {
        job_name = "traefik";
        static_configs = [{
          targets = [ "${config.services.traefik.staticConfigOptions.entryPoints.metrics.address}" ];
        }];
      }
    ];
    exporters = {
      node = {
        enable = true;
        port = 9100;
        listenAddress = "127.0.0.1";
        enabledCollectors = [ "systemd" "tcpstat" ];
      };
      nvidia-gpu = {
        enable = true;
        listenAddress = "127.0.0.1";
      };
    };
  };
}
