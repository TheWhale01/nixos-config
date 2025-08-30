{ config, ... }:

let
	traefik-vars = (import ../vars.nix).traefik;
in
{
	system.activationScripts.homepageEnv = {
		text = ''
			echo "Creating Homepage env file..."
			echo HOMEPAGE_ALLOWED_HOSTS="${traefik-vars.domain}" > /etc/homepage.env
			chmod 444 /etc/homepage.env
		'';
		deps = [];
	};
	systemd.services.homepage-dashboard.serviceConfig = {
		EnvironmentFile = [
		  "/etc/homepage.env"
			"${config.age.secrets.homepageJellyfin.path}"
			"${config.age.secrets.homepageJellyseerr.path}"
			"${config.age.secrets.homepageRadarr.path}"
			"${config.age.secrets.homepageSonarr.path}"
			"${config.age.secrets.homepageBazarr.path}"
			"${config.age.secrets.homepageProwlarr.path}"
			"${config.age.secrets.homepageTransmission.path}"
		];
	};
	services.homepage-dashboard = {
		enable = true;
		environmentFile = "/etc/homepage.env";
		widgets = [
			{
				resources = {
					cpu = true;
					disk = "/";
					memory = true;
				};
			}
			{
				datetime = {
					text_size = "sm";
					locale = "fr";
					format = {
						dateStyle = "long";
						timeStyle = "short";
					};
				};
			}
		];
		services = [
			{
				Streaming = [
					{
						Jellyfin = {
						  icon = "jellyfin.png";
							href = "https://jellyfin.${traefik-vars.domain}";
							description = "The Free Software Media System";
							widget = {
							  type = "jellyfin";
								url = "http://127.0.0.1:8096";
								key = "{{HOMEPAGE_VAR_JELLYFIN_KEY}}";
								enableBlocks = true;
								enableNowPlaying = true;
								enableUser = true;
								showEpisodeNumber = true;
								expandOneStreamToTwoRows = false;
							};
						};
					}
					{
						Jellyseerr = {
						  icon = "jellyseerr.png";
							href = "https://jellyseerr.${traefik-vars.domain}";
							description = "Open-source media request and discovery manager for Jellyfin, Plex, and Emby";
							widget = {
							  type = "jellyseerr";
								url = "http://127.0.0.1:${toString config.services.jellyseerr.port}";
								key = "{{HOMEPAGE_VAR_JELLYSEERR_KEY}}";
							};
						};
					}
					{
						Plex = {
						  icon = "plex.png";
							href = "https://plex.${traefik-vars.domain}";
							description = "Meet your TV concierge";
						};
					}
				];
			}
			{
			  "Request Utilities" = [
					{
					  Radarr = {
							icon = "radarr.png";
							description = "Movie organizer/manager for usenet and torrent users";
							href = "https://radarr.${traefik-vars.domain}";
							widget = {
							  type = "radarr";
								url = "http://127.0.0.1:${toString config.services.radarr.settings.server.port}";
								key = "{{HOMEPAGE_VAR_RADARR}}";
								enableQueue = true;
							};
						};
					}
					{
					  Sonarr = {
							icon = "sonarr.png";
							description = "Smart PVR for newsgroup and bittorrent users";
							href = "https://radarr.${traefik-vars.domain}";
							widget = {
							  type = "sonarr";
								url = "http://127.0.0.1:${toString config.services.sonarr.settings.server.port}";
								key = "{{HOMEPAGE_VAR_SONARR}}";
								enableQueue = true;
							};
						};
					}
					{
					  Bazarr = {
							icon = "bazarr.png";
							description = "Bazarr is a companion application to Sonarr and Radarr that manages and downloads subtitles based on your requirements";
							href = "https://bazarr.${traefik-vars.domain}";
							widget = {
							  type = "bazarr";
								url = "http://127.0.0.1:${toString config.services.bazarr.listenPort}";
								key = "{{HOMEPAGE_VAR_BAZARR}}";
							};
						};
					}
					{
					  Prowlarr = {
							icon = "prowlarr.png";
							description = "indexer manager/proxy built on the popular *arr stack";
							href = "https://prowlarr.${traefik-vars.domain}";
							widget = {
							  type = "prowlarr";
								url = "http://127.0.0.1:${toString config.services.prowlarr.settings.server.port}";
								key = "{{HOMEPAGE_VAR_PROWLARR}}";
							};
						};
					}
					{
					  Transmission = {
							icon = "transmission.png";
							description = "BitTorrent client";
							href = "https://transmission.${traefik-vars.domain}";
							widget = {
							  type = "transmission";
								url = "http://127.0.0.1:${toString config.services.transmission.settings.rpc-port}";
								username = "{{HOMEPAGE_VAR_TRANSMISSION_USERNAME}}";
								password = "{{HOMEPAGE_VAR_TRANSMISSION_PASSWORD}}";
								rpcUrl = "/transmission/";
							};
						};
					}
				];
			}
			{
				Useful = [
				  {
						Vaultwarden = {
						  icon = "bitwarden.png";
							href = "https://vaultwarden.${traefik-vars.domain}";
							description = "Unofficial Bitwarden compatible server written in Rust, formerly known as bitwarden_rs";
						};
					}
    		  {
    				Nextcloud = {
    				  icon = "nextcloud.png";
    					href = "https://nextcloud.${traefik-vars.domain}";
    					description = "A safe home for all you data";
    					widget = {
    					  type = "nextcloud";
    						url = "https://nextcloud.${traefik-vars.domain}";
    						key = "";
    					};
    				};
    			}
   		    {
    				OpenWebUI = {
      				icon = "open-webui.png";
       				href = "https://ai.${traefik-vars.domain}";
       				description = "User-friendly IA Interface (Supports Ollama, OpenAI API, ...)";
    				};
      		}
          {
            "Papperless-ngx" = {
              icon = "paperless-ngx.png";
              href = "https://paperless.${traefik-vars.domain}";
              description = "Scan, index and archive all your physical documents";
            };
          }
          {
            Traefik = {
              icon = "traefik.png";
              href = "https://traefik.${traefik-vars.domain}";
              description = "The Cloud Native Application Proxy";
            };
          }
				];
			}
			{
			  Widgets = [
					{
					  Calendar = {
							widget = {
							  type = "calendar";
								firstDayInWeek = "monday";
								view = "monthly";
								maxEvents = 5;
								showTime = true;
								timezone = "Europe/Paris";
								integrations = [
								  {
										type = "sonarr";
										service_group = "Request Utilities";
										service_name = "Sonarr";
										color = "cyan";
									}
									{
									  type = "radarr";
										service_group = "Request Utilities";
										service_name = "Radarr";
										color = "amber";
									}
								];
							};
						};
					}
				];
			}
			{
			  "Admin Tools" = [
					{
					  Tailscale = {
							icon = "tailscale.png";
							description = "Drop you VPN, not your standards";
						};
					}
				];
			}
		];
		customCSS = ''
* {
	font-weight: bold;
	font-family: "CaskaydiaCove Nerd Font",Manrope,Manrope-Fallback,Arial,sans-serif;
}
.service-card {
	background-color: rgba(51, 51, 51, 0.4);
}
.service-block {
	background: transparent;
}
		'';
		settings = {
			layout = {
				Streaming = {
					style = "row";
					columns = 4;
				};
				"Request Utilities" = {
					style = "row";
					columns = 4;
				};
				Useful = {
					style = "row";
					columns = 4;
				};
				Widgets = {
				  style = "row";
					columns = 4;
				};
				"Admin Tools" = {
					style = "row";
					columns = 4;
				};
			};
			theme = "dark";
			background = {
				image = "https://github.com/HyDE-Project/hyde-themes/blob/Catppuccin-Mocha/Configs/.config/hyde/themes/Catppuccin%20Mocha/wallpapers/cat_leaves.png?raw=true";
				blur = "md";
			};
			headerStyle = "clean";
			quickLaunch = {
				searchDescriptions = "true";
				hideInternetSearch = "true";
				showSearchSuggestions = "true";
				hideVisitURL = "true";
				provider = "duckduckgo";
			};
		};
	};
	services.traefik.dynamicConfigOptions.http = {
    services.homepage.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString config.services.homepage-dashboard.listenPort}";
    }];
    routers.homepage = {
      rule = "Host(`${traefik-vars.domain}`)";
      tls = true;
      service = "homepage";
      entrypoints = "websecure";
    };
  };
}
