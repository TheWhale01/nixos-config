{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    # This is to make the discord-presence extension working
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
        };
      }
    ];
    userSettings = {
      ssh_connections = [
        {
          host = "abyss";
          username = "blobfish";
          projects = [
            { paths = ["~/Codes/pappers/pappers"]; }
	    { paths = ["~/apps/translaitor"]; }
	    { paths = ["~/Codes/pappers/pappers-entreprises"]; }
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
        discord_presence = {
          initialization_options = {
            application_id = "1263505205522337886";
            # application_id = "1381368206710800475"; # customRPC
            base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
            state = "Working on {filename}";
            details = "In {workspace}";
            large_image = "{base_icons_url}/{language:lo}.png";
            large_text = "{language:u}";
            small_image = "{base_icons_url}/zed.png";
            small_text = "Zed";
            git_integration = true;
          };
        };
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
    ];
  };
}
