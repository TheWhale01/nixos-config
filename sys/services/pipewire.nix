{ ... }:

{
  services.pipewire = {
		enable = true;
		pulse.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		wireplumber.extraConfig.no-ucm = {
			"monitor.alsa.properties" = {
				"alsa.use-ucm" = false;
			};
		};
	};
}
