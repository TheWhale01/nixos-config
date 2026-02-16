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
    ./paperless.nix
    ./postgresql.nix
    ./prowlarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./tailscale.nix
    ./traefik.nix
    # ./transmission.nix
    ./vaultwarden.nix
    ./blog.nix
    ./sunshine.nix
    ./ollama.nix
    ./translaitor.nix
    # ./lidarr.nix
    ./soulseek.nix
    ./immich.nix
  ];
}
