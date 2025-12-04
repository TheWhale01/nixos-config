let
  # SSH keys used to encrypt secrets
  erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ/GL8RjU7lnxKb9YTzbdsO0O5KhMBwlbVwDZgY2LWb";
  hades = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9FADovUTXSn2694wMAViLnDJRn3TypRSzGHy3MNTo9";
in
{
  "transmission.age".publicKeys = [
    erebos
    hades
  ];
  "nextcloud.age".publicKeys = [
    erebos
    hades
  ];
  "litellm.age".publicKeys = [
    erebos
    hades
  ];
  "traefik/cf_dns_token.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/jellyfin.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/jellyseerr.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/radarr.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/sonarr.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/bazarr.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/prowlarr.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/transmission.age".publicKeys = [
    erebos
    hades
  ];
  "homepage/nextcloud.age".publicKeys = [
    erebos
    hades
  ];
}
