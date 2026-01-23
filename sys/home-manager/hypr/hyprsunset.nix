{ ... }:

{
	services.hyprsunset = {
		enable = true;
		settings = {
			profile = [
			  {
  				time = "08:00";
          temperature = 6500;
          gamma = 100;
				}
				{
  			  time = "19:00";
          temperature = 3500;
  			}
			];
		};
	};
}
