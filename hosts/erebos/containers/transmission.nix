{ config, ... }:

let
	traefik-vars = (import ../vars.nix).traefik;
in
{
	virtualisation.oci-containers.containers."transmission" = {
		image = "lscr.io/linuxserver/transmission:latest";
		environment = {
			PUID = "1000";
		        PGID = "1000";
		        TZ = "Europe/Paris";
		};
		environmentFiles = [
			config.age.secrets.transmission.path
		];
		volumes = [
			"/var/lib/transmission:/config"
			"/data/downloads:/downloads"
		];
		extraOptions = ["--network=host" "--dns=1.1.1.1"];
	};
	services.traefik.dynamicConfigOptions.http = {
		services.transmission.loadBalancer.servers = [{
			url = "http://127.0.0.1:${toString config.services.transmission.settings.rpc-port}";
    		}];
		routers.transmission = {
			rule = "Host(`transmission.${traefik-vars.domain}`)";
			tls = true;
			service = "transmission";
			entrypoints = "websecure";
		};
	};
}
