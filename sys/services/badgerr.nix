{ config, ... }:

let
	vars = import ../vars.nix;
in
{
	services.badgerr = {
		enable = true;
		jellyfinUrl = "http://127.0.0.1:${toString vars.jellyfin.port}";
		maintainerrUrl = "http://127.0.0.1:${toString vars.maintainerr.port}";
		tagname = "badgerr-overlay";
		fontUrl = "https://github.com/ryanoasis/nerd-fonts/raw/refs/heads/master/patched-fonts/RobotoMono/SemiBold/RobotoMonoNerdFont-SemiBold.ttf";
		environmentFile = config.age.secrets.badgerr.path;
		settings = {
			position = "top";
			text = {
				value = "Leaving Soon";
				font_size = 150;
				color = "#ffffff";
				background_color = "#e50914";
				padding_x = 40;
				padding_y = 40;
			};
			image = {
				background_color = "#000000";
				background_opacity = 0;
				padding_y = 100;
				padding_x = 0;
			};
		};
	};
	systemd.services.badgerr = {
	  after = [ "jellyfin.service" ];
    requires = [ "jellyfin.service" ];
    bindsTo = [ "jellyfin.service" ];
    partOf = [ "jellyfin.service" ];
	};
}
