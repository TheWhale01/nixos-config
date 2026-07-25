let
  # SSH keys used to encrypt secrets
  erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ/GL8RjU7lnxKb9YTzbdsO0O5KhMBwlbVwDZgY2LWb";
  hades = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9FADovUTXSn2694wMAViLnDJRn3TypRSzGHy3MNTo9";
in
{
  "terraform/authentik.age".publicKeys = [
    erebos
    hades
  ];
  "terraform/jellyfin.age".publicKeys = [
    erebos
    hades
  ];
  "terraform/grafana.age".publicKeys = [
    erebos
    hades
  ];
  "grafana-secret.age".publicKeys = [
    erebos
    hades
  ];
  "immich.age".publicKeys = [
    erebos
    hades
  ];
  "matrix/appservice.age".publicKeys = [
    erebos
    hades
  ];
  "matrix/alertmanager-webhook.age".publicKeys = [
    erebos
    hades
  ];
  "erebot.age".publicKeys = [
    erebos
    hades
  ];
  "livekit.age".publicKeys = [
    erebos
    hades
  ];
  "mas.age".publicKeys = [
    erebos
    hades
  ];
  "matrix/matrix.age".publicKeys = [
    erebos
    hades
  ];
  "grafana.age".publicKeys = [
    erebos
    hades
  ];
  "homepage.age".publicKeys = [
    erebos
    hades
  ];
  "vaultwarden.age".publicKeys = [
    erebos
    hades
  ];
  "authentik/proxy.age".publicKeys = [
    erebos
    hades
  ];
  "authentik/ldap.age".publicKeys = [
    erebos
    hades
  ];
  "authentik/authentik.age".publicKeys = [
    erebos
    hades
  ];
  "proton-wg.age".publicKeys = [
    erebos
    hades
  ];
  "transmission.age".publicKeys = [
    erebos
    hades
  ];
  "nextcloud.age".publicKeys = [
    erebos
    hades
  ];
  "traefik/cf_dns_token.age".publicKeys = [
    erebos
    hades
  ];
}
