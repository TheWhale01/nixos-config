{ vars, ... }:

{
  provider.authentik = {
    url = "http://127.0.0.1:${toString vars.authentik.port}";
    token = "\${trimspace(file(\"/run/agenix/authentik-terraform\"))}";
  };
  data.authentik_flow.default_authorization_flow.slug = "default-provider-authorization-explicit-consent";
  data.authentik_flow.default_invalidation_flow.slug = "default-provider-invalidation-flow";
  data.authentik_user.whale.username = "whale";
  data.authentik_property_mapping_provider_scope.email.managed = "goauthentik.io/providers/oauth2/scope-email";
  data.authentik_property_mapping_provider_scope.profile.managed = "goauthentik.io/providers/oauth2/scope-profile";
  data.authentik_property_mapping_provider_scope.openid.managed = "goauthentik.io/providers/oauth2/scope-openid";
  data.authentik_property_mapping_provider_scope.offline_access.managed = "goauthentik.io/providers/oauth2/scope-offline_access";
  data.authentik_certificate_key_pair.default = {
    name = "authentik Self-signed Certificate";
  };

  resource = {
    authentik_outpost.proxy_outpost = {
      name = "proxy-outpost";
      protocol_providers = [
        "\${authentik_provider_proxy.openbooks_provider.id}"
        "\${authentik_provider_proxy.sonarr_provider.id}"
        "\${authentik_provider_proxy.maintainerr_provider.id}"
        "\${authentik_provider_proxy.radarr_provider.id}"
        "\${authentik_provider_proxy.prowlarr_provider.id}"
        "\${authentik_provider_proxy.transmission_provider.id}"
        "\${authentik_provider_proxy.traefik_provider.id}"
        "\${authentik_provider_proxy.enableactual_provider.id}"
      ];
    };
  };
}
