{ config, ... }:

let
  db_url = "DATABASE_URL=postgresql://vaultwarden:@127.0.0.1:${toString config.services.postgresql.settings.port}/vaultwarden";
  traefik-vars = (import ../vars.nix).traefik;
in
{
  environment.etc."vaultwarden.env" = {
    text = "${db_url}";
  };
  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8222;
      SIGNUPS_ALLOWED = true;
    };
    dbBackend = "postgresql";
    environmentFile = config.age.secrets.vaultwarden.path;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.vaultwarden.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
      }
    ];
    routers.vaultwarden = {
      rule = "Host(`vaultwarden.${traefik-vars.domain}`)";
      tls = true;
      service = "vaultwarden";
      entrypoints = "websecure";
    };
  };
}
