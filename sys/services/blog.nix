# { ... }:
# 
# let
#   traefik-vars = (import ../vars.nix).traefik;
# in
# {
#   services.blog-builder = {
#     enable = true;
#     domain = "blog.thewhale.fr";
#     port = 8882;
#     publicPort = 8883;
#     user = "blogbuilder";
#   };
#   services.traefik.dynamicConfigOptions.http = {
# 	  services.blog-builder.loadBalancer.servers = [{
# 			url = "http://127.0.0.1:8882";
# 		}];
# 		services.blog.loadbalancer.servers = [{
# 		  url = "http://127.0.0.1:8883";
# 		}];
# 		routers.blog-builder = {
#   		rule = "Host(`blog.${traefik-vars.domain}`) && Path(`/webhook`)";
#   		tls = true;
#   		service = "blog-builder";
#   		entrypoints = "websecure";
# 		};
# 		routers.blog = {
#   		rule = "Host(`blog.${traefik-vars.domain}`)";
#   		tls = true;
#   		service = "blog";
#   		entrypoints = "websecure";
# 		};
#   };
# }
