{ config, pkgs, ... }:

let
  port = 8008;
  traefik-vars = (import ../vars.nix).traefik;
in
{
  users.users.mas = {
    isSystemUser = true;
    group = "mas";
    home = "/var/lib/mas";
    createHome = true;
  };
  users.groups.mas = {};
  systemd.services.mas = {
    description = "Matrix Authentication Service";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "postgresql.service" ];
    requires = [ "postgresql.service" ];

    serviceConfig = {
      Type = "simple";
      User = "mas";
      Group = "mas";
      WorkingDirectory = "${config.users.users.mas.home}";
      ExecStart = "${pkgs.matrix-authentication-service}/bin/mas-cli server --config ${config.age.secrets.mas.path}";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };
  services.matrix-synapse = {
    enable = true;
    extras = [ "oidc" ];
    extraConfigFiles = [
      config.age.secrets.matrix.path
    ];
    settings = {
      server_name = traefik-vars.domain;
      public_baseurl = "https://matrix.${traefik-vars.domain}";
      listeners = [{
        port = port;
        bind_addresses = [ "127.0.0.1" ];
        type = "http";
        tls = false;
        x_forwarded = true;
        resources = [{
          names = [ "client" "federation" ];
          compress = true;
        }];
      }];
      database = {
        name = "psycopg2";
        allow_unsafe_locale = true;
        args = {
          user = "matrix-synapse";
          database = "matrix-synapse";
          host = "/run/postgresql";
        };
      };
      max_upload_size_mib = 500;
      url_preview_enabled = true;
      enable_registration = false;
      enable_metrics = false; # for now
      registration_shared_secret_path = "/var/lib/matrix-synapse/registration_secret";
      trusted_key_servers = [{
        server_name = "matrix.org";
      }];
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services = {
      matrix.loadBalancer.servers = [{ url = "http://127.0.0.1:${toString port}"; }];
      mas.loadBalancer.servers = [{ url = "http://127.0.0.1:8009"; }];
    };
    routers = {
      matrix = {
        rule = "Host(`matrix.${traefik-vars.domain}`)";
        tls = true;
        service = "matrix";
        entrypoints = "websecure";
      };
      mas = {
        rule = "Host(`matrix-auth.${traefik-vars.domain}`)";
        tls = true;
        service = "mas";
        entrypoints = "websecure";
      };
      mas-compat = {
        # legacy SSO
        rule = "Host(`matrix.${traefik-vars.domain}`) && PathRegexp(`^/_matrix/client/(r0|v3|unstable)/(login|logout|refresh)`)";
        tls = true;
        service = "mas";
        entrypoints = "websecure";
      };
    };
  };
}
