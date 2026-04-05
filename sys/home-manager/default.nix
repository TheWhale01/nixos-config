{ inputs, ... }:

{
	imports = [
		./hypr/hypridle.nix
		./hypr/hyprlock
		./hypr/hyprpaper
		./hypr/hyprland.nix
		./hypr/hyprpolkitagent.nix
		./hypr/hyprsunset.nix
		./waybar
		./wlogout
		./wofi
		./dunst.nix
		./ghostty.nix
		./gtk.nix
		./zed.nix
		./direnv.nix
		./zen.nix
		./nextcloud.nix
		inputs.modules.nixosModules.homeManager
	];
}
