{ pkgs, config, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 9091;
in
{
  virtualisation.oci-containers.containers = {
    transmission = {
      image = "lscr.io/linuxserver/transmission:latest";
      extraOptions = [ "--network=container:proton" ];
      volumes = [
        "/var/lib/transmission:/config"
        "/data:/data"
      ];
      environmentFiles = [ config.age.secrets.transmission.path ];
      environment = {
        PUID = "1000";
        PGID = "982";
        TZ = "Europe/Paris";
        LOG_LEVEL = "debug";
      };
    };
    flood = {
      hostname = "flood";
      user = "1000:100";
      image = "docker.io/jesec/flood:latest";
      cmd = [ "--port" "3001" "--allowedpath" "/data" ];
      environment = {
        HOME = "/config";
        FLOOD_OPTION_auth = "none";
	FLOOD_OPTION_trurl = "http://transmission:9091/transmission/rpc";
      };
      environmentFiles = [
        config.age.secrets.transmission.path
      ];
      volumes = [
        "/var/lib/flood:/config"
        "/data:/data"
      ];
      extraOptions = [ "--network=container:proton" ];
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.transmission.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers = {
      transmission = {
        rule = "Host(`transmission.${traefik-vars.domain}`)";
        tls = true;
        service = "transmission";
        entrypoints = "websecure";
        middlewares = [ "transmission-auth" ];
        priority = 10;
      };
      transmission-auth = {
        rule = "Host(`transmission.${traefik-vars.domain}`) && PathPrefix(`/outpost.goauthentik.io/`)";
        tls = true;
        service = "authentik-proxy";
        entrypoints = "websecure";
        priority = 15;
      };
    };
    middlewares.transmission-auth = {
      forwardAuth = {
        address = "http://${config.services.authentik-proxy.listenHTTP}/outpost.goauthentik.io/auth/traefik";
        trustForwardHeader = true;
        authResponseHeaders = [ "X-authentik-username" "X-authentik-groups" "X-authentik-entitlements" "X-authentik-email" "X-authentik-name" "X-authentik-uid" "X-authentik-jwt" "X-authentik-meta-jwks" "X-authentik-meta-outpost" "X-authentik-meta-provider" "X-authentik-meta-app" "X-authentik-meta-version" "Authorization" ];
      };
    };
  };
  systemd.services."podman-transmission" = {
    after = [ "podman-proton.service" ];
    requires = [ "podman-proton.service" ];
  };
}
