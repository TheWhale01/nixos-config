{ erebos, ... }:

let
  vars = import ../vars.nix;
in
{
  terraform.required_providers = {
    grafana = {
      source = "grafana/grafana";
      version = "~> 3.0";
    };
    http = {
      source = "hashicorp/http";
      version = "~> 3.0";
    };
  };

  provider.grafana = {
    url = "https://grafana.thewhale.fr";
    auth = "\${file(\"/run/agenix/grafana-terraform\")}";
  };

  data.http.node_exporter.url = "https://grafana.com/api/dashboards/1860/revisions/latest/download";
  data.http.authentik.url = "https://grafana.com/api/dashboards/14837/revisions/latest/download";

  resource.grafana_dashboard = {
    node_exporter.config_json = "\${data.http.node_exporter.response_body}";
    authentik.config_json = "\${replace(data.http.authentik.response_body, \"$${DS_PROMETHEUS}\", \"${vars.prometheus.uid}\")}";
  };
}
