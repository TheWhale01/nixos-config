{ config, pkgs, ... }:

{
  stylix = {
		enable = true;
		autoEnable = true;
		image = ./hypr/wallpapers/black_hole_by_kurzgesagt.png;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

		targets = {
			hyprland.enable = false;
			rofi.enable = false;
		};

		fonts = {
			serif = {
				package = pkgs.nerd-fonts.caskaydia-cove;
				name = "CaskaydiaCove Nerd Font";
			};
			sansSerif = {
				package = pkgs.nerd-fonts.caskaydia-cove;
				name = "CaskaydiaCove Nerd Font";
			};
			monospace = {
				package = pkgs.nerd-fonts.caskaydia-cove;
				name = "CaskaydiaCove Nerd Font Mono";
			};
		};
	};
}
