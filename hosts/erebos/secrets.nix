{
	age = {
		secrets = {
			transmission = {
				file = ../../secrets/transmission.age;
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
			homepageJellyfin = {
				file = ../../secrets/homepage/jellyfin.age;
			};
			homepageJellyseerr = {
				file = ../../secrets/homepage/jellyseerr.age;
			};
			homepageRadarr = {
				file = ../../secrets/homepage/radarr.age;
			};
			homepageSonarr = {
				file = ../../secrets/homepage/sonarr.age;
			};
			homepageBazarr = {
				file = ../../secrets/homepage/bazarr.age;
			};
			homepageProwlarr = {
				file = ../../secrets/homepage/prowlarr.age;
			};
			homepageTransmission = {
				file = ../../secrets/homepage/transmission.age;
			};
			homepageNextcloud = {
			  file = ../../secrets/homepage/nextcloud.age;
			};
		};
	};
}
