{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          alt-i = "workspace::ToggleBottomDock";
          ctrl-b = null;
        };
      }
      {
        context = "Editor && (vim_mode == normal || vim_mode == visual) && !VimWaiting && !menu";
        bindings = {
          "space f f" = "file_finder::Toggle";
          "space f g" = "pane::DeploySearch";
          "space e" = "project_panel::ToggleFocus";
        };
      }
    ];
    userSettings = {
      ssh_connections = [
        {
          host = "erebos";
          username = "hades";
          projects = [
       	    { paths = ["~/nix"]; }
          ];
        }
	{
	  host = "192.168.122.174";
	  username = "whale";
	  projects = [
	    { paths = [ "~/code/Inception-of-Things" ]; }
	  ];
	}
      ];
      ui_font_size = lib.mkForce 18;
      buffer_font_size = lib.mkForce 18;
      wrap_guides = [ 80 ];
      format_on_save = "off";
      icon_theme = "Material Icon Theme";
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      vim_mode = true;
      relative_line_numbers = true;
      languages = {
        Markdown = {
          soft_wrap = "preferred_line_length";
          preferred_line_length = 80;
        };
      };
      theme = lib.mkForce {
        mode = "dark";
        dark = "Catppuccin Mocha";
        light = "Catppuccin Latte";
      };
      lsp = {
        nil = {
          autoArchive = true;
        };
      };
    };
    extensions = [
      "nix"
      "material-icon-theme"
      "catppuccin"
      "php"
      "zed-laravel-blade"
      "vue"
      "svelte"
      "zed-env"
      "zed-asm"
      "zed-make"
      "git_firefly"
      "ruby"
    ];
  };
}
