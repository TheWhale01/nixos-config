{
  terraform.required_providers = {
    authentik.source = "goauthentik/authentik";
    grafana.source = "grafana/grafana";
    http.source = "hashicorp/http";
  };

  imports = [
    # ./jellyfin.nix
    ./authentik.nix
    ./enableactual.nix
    ./grafana.nix
    ./maintainerr.nix
    ./openbooks.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./traefik.nix
    ./transmission.nix
  ];
}
