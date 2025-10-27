{ ... }:

{
	imports = [
		./home-manager
	];

	home.username = "poseidon";
	home.homeDirectory = "/home/poseidon";
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
