{ config, pkgs, lib, ... }:

{
	services.dunst = {
		enable = true;
		settings = {
			global = {
				corner_radius = lib.mkDefault 10;
				font = lib.mkDefault "CaskaydiaCove NF 18";
				icon_corner_radius = lib.mkDefault 10;
			};
		};
	};
}
