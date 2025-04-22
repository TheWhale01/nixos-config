{ config, pkgs, ... }:

{
	programs.waybar = {
		enable = true;
		# style = config.lib.readFile (./style.css);
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				mod = "dock";
				height = 34;
				exclusive = true;
				passthrough = false;
				gtk-layer-shell = true;
				reload_style_on_change = true;
				modules-left = [
					"custom/padd"
					"custom/l_end"
					"cpu"
					"memory"
					"custom/cpuinfo"
					"custom/gpuinfo"
					"custom/r_end"
					"custom/l_end"
					"idle_inhibitor"
					"clock"
					"custom/r_end"
					"custom/padd"
				];

				modules-center = [
					"custom/padd"
					"custom/l_end"
					"hyprland/workspaces"
					"hyprland/window"
					"custom/r_end"
					"custom/padd"
				];

				modules-right = [
					"custom/padd"
					"custom/l_end"
					"backlight"
					"network"
					"pulseaudio"
					"pulseaudio#microphone"
					"custom/r_end"
					"custom/l_end"
					"privacy"
					"tray"
					"battery"
					"power-profiles-daemon"
					"custom/r_end"
					"custom/l_end"
					# "custom/wallchange"
					"custom/theme"
					"custom/wbar"
					"custom/cliphist"
					"custom/power"
					"custom/r_end"
					"custom/padd"
				];

				cpu = {
				    interval = 10;
				    format = "󰍛 {usage}%";
				    rotate = 0;
				    format-alt = "{icon0}{icon1}{icon2}{icon3}";
				    format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
				};

				memory = {
				    states = {
					"c" = 90;
					"h" = 60;
					"m" = 30;
				    };
				    interval = 30;
				    format = "󰾆 {used}GB";
				    rotate = 0;
				    format-m = "󰾅 {used}GB";
				    format-h = "󰓅 {used}GB";
				    format-c = " {used}GB";
				    format-alt = "󰾆 {percentage}%";
				    max-length = 10;
				    tooltip = true;
				    tooltip-format = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
				};

				"custom/cpuinfo" = {
				    exec = "$HOME/nix/home-manager/waybar/scripts/cpuinfo.sh";
				    return-type = "json";
				    format = "{}";
				    rotate = 0;
				    interval = 5;
				    tooltip = true;
				    max-length = 1000;
				};

				"custom/gpuinfo" = {
				    exec = "$HOME/nix/home-manager/waybar/scripts/gpuinfo.sh";
				    return-type = "json";
				    format = "{}";
				    rotate = 0;
				    interva = 5;
				    tooltip = true;
				    max-length = 1000;
				    on-click = "$HOME/nix/home-manager/waybar/scripts/gpuinfo.sh --toggle";
				};

				"custom/gpuinfo#nvidia" = {
				    exec = " $HOME/nix/home-manager/waybar/scripts/gpuinfo.sh --use nvidia";
				    return-type = "json";
				    format = "{}";
				    rotate = 0;
				    interval = 5;
				    tooltip = true;
				    max-length = 1000;
				};

				"custom/gpuinfo#amd" = {
				    exec = " $HOME/nix/home-manager/waybar/scripts/gpuinfo.sh --use amd ";
				    return-type = "json";
				    format = "{}";
				    rotate = 0;
				    interval = 5;
				    tooltip = true;
				    max-length = 1000;
				};

				"custom/gpuinfo#intel" = {
				    exec = " $HOME/nix/home-manager/waybar/scripts/gpuinfo.sh --use intel ";
				    return-type = "json";
				    format = "{}";
				    rotate = 0;
				    interval = 5;
				    tooltip = true;
				    max-length = 1000;
				};

				idle_inhibitor = {
				    format = "{icon}";
				    rotate = 0;
				    format-icons = {
					activated = "󰅶 ";
					deactivated = "󰛊 ";
				    };
				    tooltip-format-activated = "Caffeine Mode Active";
				    tooltip-format-deactivated = "Caffeine Mode Inactive";
				};

				clock = {
				    format = "{:%I:%M %p}";
				    rotate = 0;
				    format-alt = "{:%R 󰃭 %d·%m·%y}";
				    tooltip-format = "<span>{calendar}</span>";
				    calendar = {
					mode = "month";
					mode-mon-col = 3;
					on-scroll = 1;
					on-click-right = "mode";
					format = {
					    months = "<span color='#ffead3'><b>{}</b></span>";
					    weekdays = "<span color='#ffcc66'><b>{}</b></span>";
					    today = "<span color='#ff6699'><b>{}</b></span>";
					};
				    };
				    actions = {
					on-click-right = "mode";
					on-click-forward = "tz_up";
					on-click-backward = "tz_down";
					on-scroll-up = "shift_up";
					on-scroll-down = "shift_down";
				    };
				};

				"hyprland/workspaces" = {
				    rotate = 0;
				    all-outputs = true;
				    active-only = false;
				    on-click = "activate";
				    disable-scroll = false;
				    on-scroll-up = "hyprctl dispatch workspace -1";
				    on-scroll-down = "hyprctl dispatch workspace +1";
				    persistent-workspaces = {};
				};

				"hyprland/window" = {
				    format = "  {}";
				    rotate = 0;
				    separate-outputs = true;
				    rewrite = {
					"khing@archlinux:(.*)" = "$1 ";
					"(.*) — Mozilla Firefox" = "$1 󰈹";
					"(.*)Mozilla Firefox" = "Firefox 󰈹";
					"(.*) - Visual Studio Code" = "$1 󰨞";
					"(.*)Visual Studio Code" = "Code 󰨞";
					"(.*) - Code - OSS" = "$1 󰨞";
					"(.*)Code - OSS" = "Code 󰨞";
					"(.*) — Dolphin" = "$1 󰉋";
					"(.*)Spotify" = "Spotify 󰓇";
					"(.*)Steam" = "Steam 󰓓";
					"(.*) - Discord" = "$1  ";
					"(.*)Netflix" = "Netflix 󰝆 ";
					"(.*) — Google chrome" = "$1  ";
					"(.*)Google chrome" = "Google chrome  ";
					"(.*) — Github" = "$1  ";
					"(.*)Github" = "Github ";
					"(.*)Spotify Free" = "Spotify 󰓇";
					"(.*)Spotify Premiun" = "Spotify 󰓇";
				    };
				    max-length = 50;
				};

				backlight = {
				    device = "intel_backlight";
				    rotate = 0;
				    format = "{icon} {percent}%";
				    format-icons = ["" "" "" "" "" "" "" "" ""];
				    tooltip-format = "{icon} {percent}% ";
				    on-scroll-up = "$HOME/nix/home-manager/waybar/scripts/brightnesscontrol.sh i 1";
				    on-scroll-down = "$HOME/nix/home-manager/waybar/scripts/brightnesscontrol.sh d 1";
				    min-length = 6;
				};

				network = {
				    tooltip = true;
				    format-wifi = " ";
				    rotate = 0;
				    format-ethernet = "󰈀 ";
				    tooltip-format = "Network = <big><b>{essid}</b></big>\nSignal strength = <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency = <b>{frequency}MHz</b>\nInterface = <b>{ifname}</b>\nIP = <b>{ipaddr}/{cidr}</b>\nGateway = <b>{gwaddr}</b>\nNetmask = <b>{netmask}</b>";
				    format-linked = "󰈀 {ifname} (No IP)";
				    format-disconnected = "󰖪 ";
				    tooltip-format-disconnected = "Disconnected";
				    format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
				    interval = 2;
				};

				pulseaudio = {
					format = "{icon} {volume}";
					rotate = 0;
					format-muted = "";
					on-click = "pavucontrol -t 3";
					on-click-right = "$HOME/nix/home-manager/waybar/scripts/volumecontrol.sh -s ''";
					on-click-middle = "$HOME/nix/home-manager/waybar/scripts/volumecontrol.sh -o m";
					on-scroll-up = "$HOME/nix/home-manager/waybar/scripts/volumecontrol.sh -o i";
					on-scroll-down = "$HOME/nix/home-manager/waybar/scripts/volumecontrol.sh -o d";
					tooltip-format = "{icon} {desc} # {volume}%";
					scroll-step = 5;
					format-icons = {
					    headphone = "";
					    hands-free = "";
					    headset = "";
					    phone = "";
					    portable = "";
					    car = "";
					    default = ["" "" ""];
					};
				};

				"pulseaudio#microphone" = {
					format = "{format_source}";
					rotate = 0;
					format-source = "";
					format-source-muted = "";
					on-click = "pavucontrol -t 4";
					on-click-middle = "$HOME/nix/home-manager/waybar/script/volumecontrol.sh -i m";
					on-scroll-up = "$HOME/nix/home-manager/waybar/script/volumecontrol.sh -i i";
					on-scroll-down = "$HOME/nix/home-manager/waybar/script/volumecontrol.sh -i d";
					tooltip-format = "{format_source} {source_desc} # {source_volume}%";
					scroll-step = 5;
				};

				privacy = {
				    icon-size = 12;
				    icon-spacing = 5;
				    transition-duration = 250;
				    modules = [
					{
					    type = "screenshare";
					    tooltip = true;
					    tooltip-icon-size = 24;
					}
					{
					    type = "audio-in";
					    tooltip = true;
					    tooltip-icon-size = 24;
					}
				    ];
				};

				tray = {
				    icon-size = 16;
				    rotate = 0;
				    spacing = 5;
				};

				battery = {
				    states = {
					good = 95;
					warning = 30;
					critical = 20;
				    };
				    format = "{icon} {capacity}%";
				    rotate = 0;
				    format-charging = " {capacity}%";
				    format-plugged = " {capacity}%";
				    format-alt = "{time} {icon}";
				    format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
				};

				power-profiles-daemon = {
					format = "{icon}";
					tooltip = true;
					tooltip-format = "Power profile = {profile}";
					format-icons = {
					    performance = " ";
					    balanced = " ";
					    power-saver = " ";
					};
				};

				# "custom/wallchange" = {
				#     format = "{}";
				#     rotate = 0;
				#     on-click = ". $HOME/nix/home-manager/waybar/scripts/change_wallpaper.sh";
				#     tooltip = true;
				#     tooltip-format = "Change wallpaper";
				# };

				"custom/power" = {
				    format = "{}";
				    rotate = 0;
				    exec = "echo ; echo  logout";
				    on-click = "$HOME/nix/home-manager/waybar/scripts/logoutlaunch.sh";
				    on-click-right = "$HOME/nix/home-manager/waybar/scripts/logoutlaunch.sh";
				    interval  = 86400;
				    tooltip = true;
				};


				# modules for padding #
				"custom/l_end" = {
				    format = " ";
				    interval  = "once";
				    tooltip = false;
				};

				"custom/r_end" = {
				    format = " ";
				    interval  = "once";
				    tooltip = false;
				};

				"custom/sl_end" = {
				    format = " ";
				    interval  = "once";
				    tooltip = false;
				};

				"custom/sr_end" = {
				    format = " ";
				    interval  = "once";
				    tooltip = false;
				};

				"custom/rl_end" = {
				    format = " ";
				    interval  = "once";
				    tooltip = false;
				};

				"custom/rr_end" = {
				    format = " ";
				    interval  = "once";
				    tooltip = false;
				};

				"custom/padd" = {
				    format = "  ";
				    interval  = "once";
				    tooltip = false;
				};
			};
		};
	};
}
