{ ... }:

let
  filename = "cv_anais.pdf";
in
{
  services.nginx = {
    enable = true;
    virtualHosts."anaisbuche.thewhale.fr" = {
      listen = [{ addr = "0.0.0.0"; port = 80; }];
      root = "/var/www/pdf";
      index = "${filename}";
      locations."/" = {
        tryFiles = [ "/${filename}" ];
	extraConfig = ''
	  add_header Content-Type application/pdf;
	  expires 7d;
	'';
      };
      locations."${filename}" = {
        tryFiles = [ "/${filename}" "=404" ];
	extraConfig = ''
	  add_header Content-Type application/pdf;
	  expires 7d;
	'';
      };
      locations."~^/" = {
	extraConfig = "autoindex off";
      };
    };
  };
}
