{ ... }:

let
  vars = import ../vars.nix;
in
{
  provider.authentik = {
    url = "http://127.0.0.1:${toString vars.authentik.port}";
    token = "\${trimspace(file(\"/run/agenix/authentik-terraform\"))}";
  };
  data.authentik_flow.default_authorization_flow.slug = "default-provider-authorization-explicit-consent";
  data.authentik_flow.default_invalidation_flow.slug = "default-provider-invalidation-flow";
  data.authentik_user.whale.username = "whale";
  data.authentik_outpost.proxy_outpost.name = "proxy-outpost";
  data.authentik_property_mapping_provider_scope.oidc_scopes = {
    managed_list = [
      "goauthentik.io/providers/oauth2/scope-openid"
      "goauthentik.io/providers/oauth2/scope-profile"
      "goauthentik.io/providers/oauth2/scope-email"
    ];
  };
}
