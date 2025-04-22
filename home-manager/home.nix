{ pkgs, ... }:

{
	imports = [
		./dunst.nix
		./ghostty.nix
		./git.nix
		./hypr/hyprlock.nix
		./hypr/hyprland.nix
		./hypr/hyprpaper.nix
		./hypr/hypridle.nix
		./rofi.nix
		./stylix.nix
		./waybar/waybar.nix
		./wlogout/wlogout.nix
		./zed.nix
		./zsh.nix
	];

	home = {
		username = "whale";
		homeDirectory = "/home/whale";
		stateVersion = "24.11";
	};

	gtk = {
		enable = true;
		iconTheme = {
			name = "Tela-circle-dark";
			package = pkgs.tela-icon-theme;
		};
	};
}
