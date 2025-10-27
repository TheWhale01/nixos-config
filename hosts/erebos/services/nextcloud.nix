{ config, pkgs, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
    services.nextcloud = {
    enable = true;
    https = true;
    hostName = "nextcloud.${traefik-vars.domain}";
    package = pkgs.nextcloud31;
    database.createLocally = true;
    configureRedis = true;
    # change where the nextcloud files are stored
    # datadir = "/data/nextcloud";
    maxUploadSize = "16G";	
    autoUpdateApps.enable = true;
    config = {
      adminuser = "whale";
      adminpassFile = "${config.age.secrets.nextcloudAdminPass.path}";
      dbtype = "pgsql";
    };
    settings = {
      trusted_domains = [ "erebos" ];
      trusted_proxies = [ "127.0.0.1"  "::1" ];
      overwriteprotocol = "https";
      overwritehost = "nextcloud.${traefik-vars.domain}";
      overwrite.cli.url = "https://nextcloud.${traefik-vars.domain}";
      filesystem_check_changes = "1";
    };
  };
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };
  services.nginx.virtualHosts."nextcloud.${traefik-vars.domain}" = {
    listen = [
      {
        addr = "127.0.0.1";
        port = 8881;
      }
    ];
		# extraConfig = ''
    		#   client_max_body_size 16G;
    		#   proxy_read_timeout 3600s;
    		#   proxy_send_timeout 3600s;
    		# '';
  };
  services.traefik.dynamicConfigOptions.http = {
    services.nextcloud.loadBalancer.servers = [{
      url = "http://127.0.0.1:8881";
    }];
    routers.nextcloud = {
      rule = "Host(`nextcloud.${traefik-vars.domain}`)";
      tls = true;
      service = "nextcloud";
      entrypoints = "websecure";
      middlewares = [ "large-upload" ];
    };
    middlewares.large-upload.buffering = {
      maxRequestBodyBytes = 17179869184;
    };
  };
}
