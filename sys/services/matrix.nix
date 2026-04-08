{ config, pkgs, ... }:

let
  port = 8008;
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.lk-jwt-service = {
    enable = true;
    port = 8004;
    livekitUrl = "wss://livekit.${traefik-vars.domain}";
    keyFile = config.age.secrets.livekit.path;
  };
  services.livekit = {
    enable = true;
    keyFile = config.age.secrets.livekit.path;
    settings = {
      port = 7880;
      rtc = {
        tcp_port = 7881;
        udp_port = 7882;
        port_range_start = 50000;
        port_range_end = 50050;
        use_external_ip = false;
        node_ip = "2a01:e0a:ede:b0e0:336f:5bb6:d67e:7309";
      };
    };
  };
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
      server_name = "matrix.${traefik-vars.domain}";
      public_baseurl = "https://${config.services.matrix-synapse.settings.server_name}";
      serve_server_wellknown = true;
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
      extra_well_known_client_content = {
        "org.matrix.msc4143.rtc_foci" = [{
          type = "livekit";
          livekit_service_url = "https://livekit.${traefik-vars.domain}";
        }];
      };
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
      livekit.loadBalancer.servers = [{ url = "http://127.0.0.1:${toString config.services.livekit.settings.port}"; }];
      lk-jwt.loadBalancer.servers = [{ url = "http://127.0.0.1:${toString config.services.lk-jwt-service.port}"; }];
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
        rule = "Host(`matrix.${traefik-vars.domain}`) && PathRegexp(`^/_matrix/client/(r0|v3|v1|unstable)/(login|logout|refresh)`)";
        tls = true;
        service = "mas";
        entrypoints = "websecure";
      };
      livekit = {
        rule = "Host(`livekit.${traefik-vars.domain}`)";
        tls = true;
        service = "livekit";
        entrypoints = "websecure";
      };
      lk-jwt = {
        rule = "Host(`livekit.${traefik-vars.domain}`) && PathPrefix(`/sfu/`)";
        tls = true;
        service = "lk-jwt";
        entrypoints = "websecure";
      };
    };
  };
  networking.firewall = {
    allowedTCPPorts = [ config.services.livekit.settings.rtc.tcp_port ];
    allowedUDPPorts = [ config.services.livekit.settings.rtc.udp_port ];
    allowedUDPPortRanges = [{ from = config.services.livekit.settings.rtc.port_range_start; to = config.services.livekit.settings.rtc.port_range_end; }];
  };
}
