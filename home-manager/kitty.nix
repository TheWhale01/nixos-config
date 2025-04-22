{ config, pkgs, ... }:

{
	programs.kitty = {
		enable = true;
		settings = {
			font_size = 18.0;
			window_padding_width = 25;
			bold_font = "auto";
			italic_font = "auto";
			enable_bell = "no";
			cursor_trail = 1;
		};
	};
}
