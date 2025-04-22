{ config, pkgs, ... }:

let
	inherit (config.lib.formats.rasi) mkLiteral;
in
{
	programs.rofi = {
		enable = true;
		package = pkgs.rofi-wayland;
		theme = {
			"*" = {
			    main-bg = mkLiteral "#11111be6";
			    main-fg = mkLiteral "#cdd6f4ff";
			    main-br = mkLiteral "#cba6f7ff";
			    main-ex = mkLiteral "#f5e0dcff";
			    select-bg = mkLiteral "#b4befeff";
			    select-fg = mkLiteral "#11111bff";
			    separatorcolor = mkLiteral "transparent";
			    border-color = mkLiteral "transparent";
			};

			"configuration" = {
			    modi = "drun,filebrowser,window,run";
			    show-icons = true;
			    display-drun = " ";
			    display-run = " ";
			    display-filebrowser = " ";
			    display-window = " ";
			    drun-display-format = "{name}";
			    window-format = "{w}{t}";
			    font = "CaskaydiaCove NF 10";
			    icon-theme = "Tela-circle-dracula";
			};

			"window" = {
			    height = mkLiteral "30em";
			    width = mkLiteral "57em";
			    transparency = "real";
			    fullscreen = false;
			    enabled = true;
			    cursor = "default";
			    spacing = mkLiteral "0em";
			    padding = mkLiteral "0em";
			    border-color = mkLiteral "@main-br";
			    background-color = mkLiteral "@main-bg";
			    border-radius = mkLiteral "1em";
			    border = mkLiteral "0.15em";
			};

			"mainbox" = {
			    enabled = true;
			    spacing = mkLiteral "1em";
			    padding = mkLiteral "1em";
			    orientation = mkLiteral "horizontal";
			    children = [ "inputbar" "listbox" ];
			    background-color = mkLiteral "transparent";
			    border-radius = mkLiteral "1em";
			};

			"inputbar" = {
			    enabled = true;
			    width = mkLiteral "27em";
			    spacing = mkLiteral "0em";
			    padding = mkLiteral "0em";
			    children = [ "entry" ];
			    background-color = mkLiteral "transparent";
			    background-image = mkLiteral "url('/home/whale/nix/home-manager/assets/wall.sqre.jpg', height)";
			    border-radius = mkLiteral "1em";
			};

			"entry" = {
			    enabled = false;
			};

			"listbox" = {
			    spacing = mkLiteral "0em";
			    padding = mkLiteral "0em";
			    children = [ "dummy" "listview" "dummy" ];
			    background-color = mkLiteral "transparent";
			};

			"listview" = {
			    enabled = true;
			    spacing = mkLiteral "0em";
			    padding = mkLiteral "1em";
			    columns = 1;
			    lines = 7;
			    cycle = true;
			    dynamic = true;
			    scrollbar = false;
			    layout = mkLiteral "vertical";
			    reverse = false;
			    expand = false;
			    fixed-height = true;
			    fixed-columns = true;
			    cursor = "default";
			    background-color = mkLiteral "transparent";
			    text-color = mkLiteral "@main-fg";
			};

			"dummy" = {
			    background-color = mkLiteral "transparent";
			};

			"element" = {
			    enabled = true;
			    spacing = mkLiteral "1em";
			    padding = mkLiteral "0.5em 0.5em 0.5em 1.5em";
			    cursor = mkLiteral "pointer";
			    background-color = mkLiteral "transparent";
			    text-color = mkLiteral "@main-fg";
			    border-radius = mkLiteral "1em";
			};

			"element selected.normal" = {
			    background-color = mkLiteral "@select-bg";
			    text-color = mkLiteral "@select-fg";
			};

			"element-icon" = {
			    size = mkLiteral "2.7em";
			    cursor = mkLiteral "inherit";
			    background-color = mkLiteral "transparent";
			    text-color = mkLiteral "inherit";
			};

			"element-text" = {
			    vertical-align = mkLiteral "0.5";
			    horizontal-align = mkLiteral "0.0";
			    cursor = mkLiteral "inherit";
			    background-color = mkLiteral "transparent";
			    text-color = mkLiteral "inherit";
			};

			"error-message" = {
			    text-color = mkLiteral "@main-fg";
			    background-color = mkLiteral "@main-bg";
			    text-transform = mkLiteral "capitalize";
			    children = [ "textbox" ];
			};

			"textbox" = {
			    text-color = mkLiteral "inherit";
			    background-color = mkLiteral "inherit";
			    vertical-align = mkLiteral "0.5";
			    horizontal-align = mkLiteral "0.5";
			};
		};
	};
}
