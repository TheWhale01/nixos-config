{ ... }:

let
  filename = "portfolio_anais.pdf";
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.nginx = {
    enable = true;
    virtualHosts."anaisbuche.thewhale.fr" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8002;
        }
      ];
      root = "/var/www/pdf";
      locations."/" = {
        tryFiles = "/${filename} =404";
        extraConfig = ''
          add_header Content-Type application/pdf;
        '';
      };
    };
  };
  services.traefik.dynamicConfigOptions.http = {
    services.anaisbuche.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:8002";
      }
    ];
    routers.anaisbuche = {
      rule = "Host(`anaisbuche.${traefik-vars.domain}`)";
      tls = true;
      service = "anaisbuche";
      entrypoints = "websecure";
    };
  };
}
