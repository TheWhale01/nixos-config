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
          "alt-i" = "workspace::ToggleBottomDock";
          "ctrl-b" = null;
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
          host = "thewhale.fr";
          nickname = "erebos";
          username = "hades";
          projects = [
       	    { paths = ["~/nix"]; }
          ];
        }
        {
          host = "100.115.94.1";
          nickname = "erebos";
          username = "hades";
          projects = [
       	    { paths = ["~/nix"]; }
          ];
        }
        {
          host = "100.82.205.106";
          nickname = "erebos-stage";
          username = "hades";
          projects = [
       	    { paths = ["~/nix"]; }
          ];
        }
      ];
      lsp_document_colors = "background";
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
      use_podman = true;
      relative_line_numbers = "enabled";
      languages = {
        Markdown = {
          soft_wrap = "bounded";
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
      "zed-env"
      "git_firefly"
    ];
  };
}
