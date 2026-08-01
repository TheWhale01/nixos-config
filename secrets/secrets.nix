let
  # SSH keys used to encrypt secrets
  erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ/GL8RjU7lnxKb9YTzbdsO0O5KhMBwlbVwDZgY2LWb";
  erebos-stage = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINh/imYjgxInWiS5uKlTuabmuG+0VL2HWEfQ43NczK1O";
  hades = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9FADovUTXSn2694wMAViLnDJRn3TypRSzGHy3MNTo9";
  hades-stage = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM25SgGES1eclegLiVqRCNyhpK+k4GnFQJvw9p3o65Eb";
in
{
  "hades.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "actualbudget.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "terraform/traefik.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "terraform/authentik.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "terraform/jellyfin.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "terraform/grafana.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "grafana-secret.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "immich.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "matrix/appservice.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "matrix/alertmanager-webhook.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "matrix/erebot.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "matrix/livekit.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "matrix/mas.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "matrix/matrix.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "grafana.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "homepage.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "vaultwarden.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "authentik/proxy.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "authentik/ldap.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "authentik/authentik.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "proton-wg.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "transmission.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "nextcloud.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
  "traefik/cf_dns_token.age".publicKeys = [
    erebos
    erebos-stage
    hades
    hades-stage
  ];
}
