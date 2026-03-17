{ ... }:

{
  imports = [
    ./bazarr.nix
    ./homepage.nix
    ./jellyfin/jellyfin.nix
    ./jellyseerr.nix
    ./nextcloud.nix
    ./nginx.nix
    ./openssh.nix
    ./postgresql.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./traefik.nix
    ./vaultwarden.nix
    ./blog.nix
    ./ollama.nix
    ./immich.nix
    ./cleanerr.nix
    ./authentik.nix
    ./matrix.nix
    ./monitoring
  ];
}
