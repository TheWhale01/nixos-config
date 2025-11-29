{ config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.traefik = {
    enable = true;
    staticConfigOptions = {
      log = {
        level = "DEBUG";
      };
      api = {};
      entryPoints = {
        web = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "websecure";
            scheme = "https";
          };
        };
        websecure = {
          address = ":443";
        };
      };
      certificatesResolvers = {
        "${traefik-vars.dns_provider}" = {
          acme = {
            email = "ard.rasp01@gmail.com";
            storage = "${config.services.traefik.dataDir}/acme.json";
            caserver = "https://acme-v02.api.letsencrypt.org/directory";
            dnsChallenge = {
              provider = "${traefik-vars.dns_provider}";
              resolvers = ["1.1.1.1:53" "8.8.8.8:53"];
            };
          };
        };
      };
    };
    dynamicConfigOptions = {
      http = {
        middlewares = {
          traefik-auth = {
            basicAuth = {
              users = ["whale:$apr1$TROUcwCk$tXXXbRj7rp6g.yRQiE7gR0"];
            };
          };
        };
        routers = {
          traefik = {
            rule = "Host(`traefik.${traefik-vars.domain}`)";
            service = "api@internal";
            entrypoints = ["websecure"];
            middlewares = ["traefik-auth"];
            tls = {
              certResolver = "${traefik-vars.dns_provider}";
              domains = [{ main = "${traefik-vars.domain}"; sans = "*.${traefik-vars.domain}"; }];
            };
          };
        };
      };
    };
  };
  # Passing env variables to service
  systemd.services.traefik.serviceConfig = {
    EnvironmentFile = ["${config.age.secrets.traefikCfDnsToken.path}"];
  };
}
