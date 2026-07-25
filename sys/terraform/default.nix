{
  terraform.required_providers = {
    authentik.source = "goauthentik/authentik";
    grafana.source = "grafana/grafana";
    http.source = "hashicorp/http";
  };

  imports = [
    # ./jellyfin.nix
    ./authentik.nix
    ./grafana.nix
    ./maintainerr.nix
    ./openbooks.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
  ];
}
