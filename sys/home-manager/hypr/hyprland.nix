{ inputs, ... }:

{
	xdg.configFile.hypr = {
	  source = inputs.hyprconf;
		recursive = true;
	};
}
