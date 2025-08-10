{ ... }:

let
	traefik-vars = (import ../vars.nix).traefik;
	port = 8080;
in
{
	virtualisation.oci-containers.containers."open-webui" = {
		image = "ghcr.io/open-webui/open-webui:latest";
		volumes = [ "open-webui_vol:/app/backend/data" ];
		ports = [ "${toString port}:8080" ];
	};
	services.traefik.dynamicConfigOptions.http = {
		services.open-webui.loadBalancer.servers = [{
			url = "http://127.0.0.1:${toString port}";
		}];
		routers.open-webui = {
			rule = "Host(`ai.${traefik-vars.domain}`)";
			tls = true;
			service = "open-webui";
			entrypoints = "websecure";
		};
	};
}
