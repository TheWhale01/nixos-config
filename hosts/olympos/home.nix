{ ... }:

{
	imports = [
		./home-manager
	];

	home.username = "zeus";
	home.homeDirectory = "/home/zeus";
	home.stateVersion = "25.05";

	programs.home-manager.enable = true;

	stylix = {
		targets = {
			hyprland.enable = false;
			waybar.enable = false;
			wofi.enable = false;
			hyprlock.enable = false;
		};
	};
}
