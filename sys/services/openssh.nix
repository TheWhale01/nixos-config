{ ... }:

{
	services.openssh = {
		enable = true;
		ports = [ 22 ];
		settings = {
			PasswordAuthentication = true;
			AllowUsers = [ "hades" ];
			UseDns = true;
			X11Forwarding = false;
			PermitRootLogin = "no";
		};
	};
}
