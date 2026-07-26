{
  terraform.required_providers = {
    authentik.source = "goauthentik/authentik";
    grafana.source = "grafana/grafana";
    http.source = "hashicorp/http";
  };
  data.authentik_property_mapping_provider_scope.oidc_scopes = {
    managed_list = [
      "goauthentik.io/providers/oauth2/scope-email"
      "goauthentik.io/providers/oauth2/scope-openid"
      "goauthentik.io/providers/oauth2/scope-profile"
    ];
  };

  imports = [
    # ./jellyfin.nix
    ./authentik.nix
    ./enableactual.nix
    ./grafana.nix
    ./maintainerr.nix
    ./matrix.nix
    ./openbooks.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./traefik.nix
    ./transmission.nix
  ];
}
