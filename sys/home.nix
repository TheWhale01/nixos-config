{ pkgs, ... }:

{
	imports = [
		./home-manager
	];

	home.username = "poseidon";
	home.homeDirectory = "/home/poseidon";
	home.stateVersion = "26.05";

	programs.home-manager = {
		enable = true;
		package = pkgs.home-manager;
	};

	stylix = {
		targets = {
			hyprland.enable = false;
			waybar.enable = false;
			wofi.enable = false;
			hyprlock.enable = false;
     	zen-browser.profileNames = [ "default" ];
		};
	};
}
