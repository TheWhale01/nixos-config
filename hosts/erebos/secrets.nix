{
	age = {
		secrets = {
			transmission = {
				file = ../../secrets/transmission.json;
				owner = "transmission";
				group = "transmission";
			};
			traefikCfDnsToken= {
				file = ../../secrets/traefik/cf_dns_token.age;
				owner = "traefik";
				group = "traefik";
			};
			nextcloudAdminPass = {
				file = ../../secrets/nextcloud.age;
			};
			litellm = {
				file = ../../secrets/litellm.age;
			};
		};
	};
}
