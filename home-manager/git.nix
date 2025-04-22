{ config, pkgs, ... }:

{
	programs.git = {
		enable = true;
		userName = "TheWhale01";
		userEmail = "ard.rasp01@gmail.com";
		extraConfig.init.defaultBranch = "main";
	};
}
