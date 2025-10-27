{ config, pkgs, ... }:

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
  systemd.services.get_xmltv = {
    enable = true;
    startAt = "daily";
    serviceConfig = {
      Type = "oneshot";
      User = "${config.services.jellyfin.user}";
    };
    script = "${pkgs.writeShellScript "get_xmltv.sh" ''
      ${pkgs.wget}/bin/wget -O ${config.services.jellyfin.dataDir}/xmltv.zip "https://xmltvfr.fr/xmltv/xmltv.zip"
      ${pkgs.unzip}/bin/unzip -o ${config.services.jellyfin.dataDir}/xmltv.zip -d ${config.services.jellyfin.dataDir}
      ${pkgs.coreutils}/bin/rm -f ${config.services.jellyfin.dataDir}/xmltv.zip
    ''}";
  };
  systemd.services.get_m3u_file = {
    enable = true;
    serviceConfig = {
      Type = "oneshot";
      User = "${config.services.jellyfin.user}";
    };
    script = "${pkgs.writeShellScript "get_m3u_file" ''
      ${pkgs.wget}/bin/wget -O ${config.services.jellyfin.dataDir}/playlist.m3u "http://mafreebox.freebox.fr/freeboxtv/playlist.m3u"
      echo "#EXTM3U" > ${config.services.jellyfin.dataDir}/freebox_tmp.m3u
      sed -n '/(HD)/{p;n;p}' ${config.services.jellyfin.dataDir}/playlist.m3u | grep -v "^#EXTM3U" >> ${config.services.jellyfin.dataDir}/freebox_tmp.m3u
      < ${config.services.jellyfin.dataDir}/freebox_tmp.m3u sed 's/ (HD)//' > ${config.services.jellyfin.dataDir}/freebox.m3u
      rm ${config.services.jellyfin.dataDir}/playlist.m3u ${config.services.jellyfin.dataDir}/freebox_tmp.m3u
    ''}";
  };
}
