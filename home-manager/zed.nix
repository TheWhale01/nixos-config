{ pkgs, lib, ... }:

{
	programs.zed-editor = {
		enable = true;
		extensions = [ "zed" "php" "dockerfile" "git-firefly" "vue" "docker-compose"
		  "pylsp" "material-icon-theme" "env" "blade" "nix" "catppuccin"];
		userKeymaps = [
			{
				context = "Workspace";
				bindings = {
					"alt-i" = "workspace::ToggleBottomDock";
					"ctrl-b" = null;
				};
			}
			{
			 context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
				bindings = {
				  "space f f" = "file_finder::Toggle";
					"space f s" = "pane::DeploySearch";
				};
			}
		];
		userSettings = {
		  vim_mode = true;
		  wrap_guides = [ 80 ];
			format_on_save = "off";
			icon_theme = "Material Icon Theme";
			telemetry = {
			 metrics = false;
				diagnostics = false;
			};
			ui_font_size = lib.mkDefault 18;
			buffer_font_size = lib.mkDefault 18;
			relative_line_numbers = true;
			theme = lib.mkForce "Catppuccin Mocha";
			show_edit_predictions = false;
			languages = {
			  Markdown = {
					soft_wap = "preferred_line_length";
					preferred_line_length = 80;
				};
			};
		};
		extraPackages = with pkgs; [
		  nixd
			nil
		];
	};
}
