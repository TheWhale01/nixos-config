{ config, pkgs, ... }:

let
	wallpaper = "$HOME/nix/home-manager/hypr/wallpapers/black_hole_by_kurzgesagt.png";
in
{
	services.hyprpaper = {
		enable = true;
		# settings = {
		# 	preload = [
		# 		"${wallpaper}"
		# 	];

		# 	wallpaper = [
		# 		"${wallpaper}"
		# 	];
		# };
	};
}
