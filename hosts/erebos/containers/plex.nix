{ ... }:

let
	port = 32400;
in
{
	virtualisation.oci-containers.containers."plex" = {
		image = "lscr.io/linuxserver/plex:latest";
		volumes = [
			"/data/Movies:/movies"
		];
		ports = [ "${toString port}:32400" ];
	};
}
