{ config, pkgs, ... }:

{
	programs.hyprlock = {
		enable = true;
		settings = {
			"$fontFamily" = "CaskaydiaCove Nerd Font";
			"$fn_greet" = "echo \"Good $(date +%H | awk '{if ($1 < 12) print \"Morning\"; else if ($1 < 18) print \"Afternoon\"; else print \"Evening\"}'), $USER\"";
			background = {
				blur_passes = 2;
			};

		 	general = {
		 		no_fade_in = false;
		 		grace = 0;
		 		disable_loading_bar = true;
		 	};

			# USER AVATAR
			image = {
				monitor = "";
				path = "$HOME/nix/home-manager/assets/mpris.jpg";
				size = 150;
				reload_time = 0;
				reload_cmd = "";
				position = "0, 0";
				halign = "center";
				valign = "center";
			};

		 	# INPUT FIELD
		 	input-field = {
				font_family = "$fontFamily";
				monitor = "";
				size = "200, 50";
				outline_thickness = 3;
				dots_size = 0.33;
				dots_spacing = 0.15;
				dots_center = true;
				dots_rounding = -1;
				fade_on_empty = true;
				fade_timeout = 1000;
				placeholder_text = "<i>Input Password...</i> # Text rendered in the input box when it's empty.";
				hide_input = false;
				rounding = -1;
				fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
				fail_transition = 300;
				capslock_color = -1;
				numlock_color = -1;
				bothlock_color = -1;
				invert_numlock = false;
				swap_font_color = true;
				position = "0, 80";
				halign = "center";
				valign = "bottom";
		 	};

		 	label = [
		 		# TIME
		 		{
					font_family = "$fontFamily";
		 			monitor = "";
		 			text = "$TIME";
		 			font_size = 90;
		 			position = "-30, 0";
		 			halign = "right";
		 			valign = "top";
		 		}
		 		# DATE
		 		{
					font_family = "$fontFamily";
		 			monitor = "";
		 			text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
		 			font_size = 25;
		 			position = "-30,-150";
		 			halign = "right";
		 			valign = "top";
		 		}
		 		# USER Greeting
		 		{
					font_family = "$fontFamily";
		 			monitor = "";
		 			text = "cmd[update:60000] $fn_greet";
		 			color = "$text";
		 			font_size = 20;
		 			position = "0, -190";
		 			halign = "center";
		 			valign = "center";
		 		}
		 		# Mpris and SPLASH
		 		{
		 			monitor = "";
		 			text = "cmd[update:1000] $SPLASH_CMD";
		 			font_size = 15;
		 			position = "0, 0";
		 			halign = "center";
		 			valign = "bottom";
		 		}
		 		# Battery Status if present
		 		{
		 			monitor = "";
		 			text = "cmd[update:5000] $BATTERY_ICON";
		 			font_size = 20;
		 			position = "-1%, 1%";
		 			halign = "right";
		 			valign = "bottom";
		 		}
		 		# Current Keyboard Layout 
		 		{
					font_family = "$fontFamily";
		 			monitor = "";
		 			text = "cmd[update:1000] $KEYBOARD_LAYOUT";
		 			font_size = 20;
		 			position = "-2%, 1%";
		 			halign = "right";
		 			valign = "bottom";
		 		}
		 	];
		};
	};
}
