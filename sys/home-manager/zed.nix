{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;
    mutableUserSettings = true;
    mutableUserKeymaps = true;
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
      assistant = {
        node = {
          path = lib.getExe pkgs.nodejs;
          npm_path = lib.getExe' pkgs.nodejs "npm";
        };
      };
      ssh_connections = [
        {
          host = "192.168.1.154";
          nickname = "erebos";
          username = "hades";
          projects = [
       	    { paths = ["~/nix"]; }
            { paths = ["~/code/blog-builder"]; }
            { paths = ["~/code/Lumiere"]; }
            { paths = ["~/code/translaitor"]; }
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
      relative_line_numbers = "enabled";
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
