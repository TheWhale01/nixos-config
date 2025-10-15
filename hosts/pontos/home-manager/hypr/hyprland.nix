{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # VARIABLES
      "$&"="override";
      "$mainMod" = "SUPER";
      "$terminal" = "ghostty";
      "$fileManager" = "nautilus";
      "$menu" = "wofi --show drun";
      "$browser" = "zen";
      "$code-editor" = "zeditor";
      "$screenshot" = "hyprshot";
      # APPEARANCE
      # EXEC ONCE
      exec-once = [
        "waybar"
        "nm-applet"
        "blueman-applet"
      ];
      animations = {
        enabled = true;
        bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
	exit_window_retains_fullscreen = true;
      };
      general = {
        gaps_in = 3;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        layout = "dwindle";
        resize_on_border = true;
      };
      group = {
        "col.border_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
        "col.border_locked_active" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.border_locked_inactive" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
      };
      decoration = {
        rounding = 10;
        blur = {
          enabled = "yes";
          size = 6;
          passes = 3;
          new_optimizations = "on";
          ignore_opacity = "on";
          xray = false;
        };
      };
      input = {
        kb_layout = "us";
        follow_mouse = 0;
        sensitivity = 0;
        mouse_refocus = 0;
        touchpad = {
          natural_scroll = true;
        };
      };
      # KEYBINDINGS
      bind = [
        "$mainMod, F, fullscreen"
        "$mainMod, T, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, delete, exit,"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, W, togglefloating,"
        "$mainMod, A, exec, $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$mainMod, J, togglesplit, # dwindle"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, B, exec, $browser"
        "$mainMod, C, exec, $code-editor"
        "$mainMod, PRINT, exec, hyprshot -m window"
        ", PRINT, exec, hyprshot -m output"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, ${./scripts/volumecontrol.sh} -o i"
        ",XF86AudioLowerVolume, exec, ${./scripts/volumecontrol.sh} -o d"
        ",XF86AudioMute, exec, ${./scripts/volumecontrol.sh} -o m"
        ",XF86AudioMicMute, exec, ${./scripts/volumecontrol.sh} -i m"
        ",XF86MonBrightnessUp, exec, ${./scripts/brightnesscontrol.sh} i"
        ",XF86MonBrightnessDown, exec, ${./scripts/brightnesscontrol.sh} d"
      ];
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
        ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, 2880x1920, 0x0, 1.5\""
      ];
      # MONITORS
      monitor = [
        "eDP-1,preferred,auto,1.5"
        ",preferred,auto,1"
      ];
      windowrulev2 = [
        "opacity 0.80 $& 0.80 $& 1,class:^(com.mitchellh.ghostty)$"
        "opacity 0.80 $& 0.80 $& 1,class:^(vesktop)$"
        "fullscreen,class:com.moonlight_stream.Moonlight"
	"fullscreen,title:Steam Big Picture Mode"
      ];
      layerrule = [
        "blur,waybar"
        "ignorezero,rofi"
        "blur,notifications"
        "ignorezero,notifications"
        "blur,swaync-notification-window"
        "ignorezero,swaync-notification-window"
        "blur,swaync-control-center"
        "ignorezero,swaync-control-center"
        "blur,logout_dialog"
      ];
      debug = {
        full_cm_proto = true;
      };
    };
  };
}
