{ config, pkgs, ... }:

let
  traefik-vars = (import ../../vars.nix).traefik;
  port = 8096;
in
{
  services.jellyfin = {
    enable = true;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.jellyfin.loadBalancer.servers = [
      {
        url = "http://127.0.0.1:${toString port}";
      }
    ];
    routers.jellyfin = {
      rule = "Host(`jellyfin.${traefik-vars.domain}`)";
      tls = true;
      service = "jellyfin";
      entrypoints = "websecure";
    };
  };
  services.lumiere = {
    enable = true;
    environmentFile = "${config.age.secrets.lumiere.path}";
    user = "${config.services.jellyfin.user}";
    group = "${config.services.jellyfin.group}";
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
      Environment = [
        "JELLYFIN_DATA_DIR=${config.services.jellyfin.dataDir}"
        "M3U_URL=http://mafreebox.freebox.fr/freeboxtv/playlist.m3u"
      ];
    };
    path = with pkgs; [
      python3
      python3Packages.requests
    ];
    script = ''
      #!${pkgs.bash}/bin/bash

      ${pkgs.python3.withPackages (ps: with ps; [ requests ])}/bin/python3 ${./get_m3u.py}
    '';
  };
}
