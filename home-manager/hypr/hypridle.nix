{ config, pkgs, ...}:

{
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				lock_cmd = "pidof hyprlock || hyprlock";
				before_sleep_cmd = "loginctl lock-session";
				after_sleep_cmd = "hyprctl dispatch dpms on";
			};

			listener = [
				{
					timeout = 900;
					on-timeout = "loginctl lock-session";
				}
				{
					timeout = 1800;
					on-timeout = "systemctl suspend";
				}
			];
		};
	};
}
