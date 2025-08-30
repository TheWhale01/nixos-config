{ pkgs, ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
  port = 8096;
in
{
  services.jellyfin = {
    enable = true;
  };
  services.traefik.dynamicConfigOptions.http = {
   services.jellyfin.loadBalancer.servers = [{
      url = "http://127.0.0.1:${toString port}";
    }];
    routers.jellyfin = {
      rule = "Host(`jellyfin.${traefik-vars.domain}`)";
      tls = true;
      service = "jellyfin";
      entrypoints = "websecure";
    };
  };
  # Automating XMLTV guide download
  systemd.services.get_xmltv = {
    enable = true;
    serviceConfig.Type = "oneshot";
    script = "${pkgs.writeShellScript "get_xmltv.sh" ''
      #!/bin/bash

      ${pkgs.wget}/bin/wget -O /var/lib/jellyfin/xmltv.zip "https://xmltvfr.fr/xmltv/xmltv.zip"
      ${pkgs.unzip}/bin/unzip -o /var/lib/jellyfin/xmltv.zip -d /var/lib/jellyfin
      ${pkgs.coreutils}/bin/rm -f /var/lib/jellyfin/xmltv.zip
    ''}";
  };
  systemd.services.get_m3u_file = {
    enable = true;
    serviceConfig.Type = "oneshot";
    script = "${pkgs.writeShellScript "get_m3u_file" ''
      #!/bin/bash

      ${pkgs.wget}/bin/wget -O /var/lib/jellyfin/playlist.m3u "http://mafreebox.freebox.fr/freeboxtv/playlist.m3u"
      echo "#EXTM3U" > /var/lib/jellyfin/freebox_tmp.m3u
      sed -n '/(HD)/{p;n;p}' /var/lib/jellyfin/playlist.m3u | grep -v "^#EXTM3U" >> /var/lib/jellyfin/freebox_tmp.m3u
      < /var/lib/jellyfin/freebox_tmp.m3u sed 's/ (HD)//' > /var/lib/jellyfin/freebox.m3u
      rm /var/lib/jellyfin/playlist.m3u /var/lib/jellyfin/freebox_tmp.m3u
    ''}";
  };
  systemd.user.timers.get_xmltv = {
    enable = true;
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
