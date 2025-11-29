{ pkgs, config, ... }:

let
	users = [
		{
			name = "vaultwarden";
			ensureDBOwnership = true;
		}
		{
			name = "litellm";
			ensureDBOwnership = true;
		}
		{
			name = "nextcloud";
			ensureDBOwnership = true;
		}
		{
			name = "paperless";
			ensureDBOwnership = true;
		}
	];
	databases = [ "vaultwarden" "litellm" "nextcloud" "paperless" ];
in
{
	services.postgresql = {
		enable = true;
		enableTCPIP = true;
		authentication = ''
			host  all all 127.0.0.1/32    trust
			host  all all ::1/128         trust
			local all all                 trust
		'';
		ensureUsers = users;
		ensureDatabases = databases;
	};
}
