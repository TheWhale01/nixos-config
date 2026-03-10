{ pkgs, ... }:

let
  system-metrics-dashboard = {
    title = "System";
    uid = "system-overview-01";
    timezone = "browser";
    refresh = "2s";
    schemaVersion = 38;
    panels = [
      # CPU
      {
        type = "timeseries";
        title = "CPU Usage (%)";
        gridPos = { h = 8; w = 12; x = 0; y = 0; };
        options = {
          legend = {
            showLegend = false;
          };
        };
        fieldConfig = {
          defaults = {
            min = 0;
            max = 100;
            unit = "percent";
          };
        };
        targets = [{
          expr = "100 - (avg by (instance) (rate(node_cpu_seconds_total{mode=\"idle\"}[5m])) * 100)";
          refId = "A";
        }];
      }
      # RAM
      {
        type = "timeseries";
        title = "RAM Usage (%)";
        gridPos = { h = 8; w = 12; x = 12; y = 0; };
        options = {
          legend = {
            showLegend = false;
          };
        };
        fieldConfig = {
          defaults = {
            min = 0;
            max = 100;
            unit = "percent";
          };
        };
        targets = [{
          expr = "100 * (1 - ((node_memory_MemAvailable_bytes) / (node_memory_MemTotal_bytes)))";
          refId = "A";
        }];
      }
      # NETWORK
      {
        type = "timeseries";
        title = "Network Traffic";
        gridPos = { h = 8; w = 8; x = 0; y = 8; };
        fieldConfig = {
          defaults = {
            min = 0;
            unit = "MB/s";
          };
        };
        targets = [
          {
            expr = "rate(node_network_receive_bytes_total{device=\"enp7s0\"}[5m]) / 1048576";
            legendFormat = "Download";
            refId = "A";
          }
          {
            expr = "rate(node_network_transmit_bytes_total{device=\"enp7s0\"}[5m]) / 1048576";
            legendFormat = "Upload";
            refId = "B";
          }
        ];
      }
      # DISK
      {
        type = "bargauge";
        title = "Disk Usage";
        gridPos = { h = 8; w = 4; x = 8; y = 8; };
        options = {
          orientation = "vertical";
          displayMode = "gradient";
        };
        fieldConfig = {
          defaults = {
            min = 0;
            max = 100;
            unit = "percent";
            thresholds = {
              mode = "absolute";
              steps = [
                { value = null; color = "green"; }
                { value = 80; color = "orange"; }
                { value = 90; color = "red"; }
              ];
            };
          };
        };
        targets = [
          {
            expr = "max(100 - ((node_filesystem_avail_bytes{mountpoint=\"/\"} * 100) / node_filesystem_size_bytes{mountpoint=\"/\"}))";
            refId = "A";
            legendFormat = "/";
          }
          {
            expr = "100 - ((node_filesystem_avail_bytes{mountpoint=\"/data\"} * 100) / node_filesystem_size_bytes{mountpoint=\"/data\"})";
            refId = "B";
            legendFormat = "/data";
          }
        ];
      }
      {
        type = "timeseries";
        title = "GPU Utilization (%)";
        gridPos = { h = 8; w = 12; x = 12; y = 8; };
        options = {
          legend = {
            showLegend = false;
          };
        };
        fieldConfig = {
          defaults = {
            min = 0;
            max = 1;
            unit = "percentunit";
          };
        };
        targets = [{
          expr = "nvidia_smi_utilization_gpu_ratio";
          refId = "A";
        }];
      }
    ];
  };
in
{
  dashboard = pkgs.writeTextDir "system-dashboard.json" (builtins.toJSON system-metrics-dashboard);
}
