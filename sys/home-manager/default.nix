{ ... }:

{
	imports = [
		../../modules/neovim.nix
		../../modules/btop.nix
		../../modules/git.nix
		../../modules/zsh.nix
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
	];
}
