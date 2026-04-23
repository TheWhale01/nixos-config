{ pkgs, lib, ... }:

{
  imports = [
    ./openbooks.nix
    ./lidarr.nix
    ./transmission.nix
    ./protonvpn.nix
    ./aurral.nix
    ./nextcloud.nix
    ./maintainerr.nix
  ];

  virtualisation.containers = {
    enable = true;
    storage.settings.storage = {
      driver = "overlay";
      runroot = "/run/containers/storage";
      graphroot = "/var/lib/containers/storage";
      rootless_storage_path = "/tmp/containers-$USER";
      options.overlay.mountopt = "nodev,metacopy=on";
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      flags = [ "--all" "--force" "--volumes" ];
    };
    defaultNetwork.settings.dns_enabled = true;
  };
  virtualisation.oci-containers.backend = "podman";

  environment.extraInit = ''
    if [ -z "$DOCKER_HOST" -a -n "$XDG_RUNTIME_DIR" ]; then
      export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
    fi
  '';

  systemd.timers.update-containers = {
    timerConfig = {
      Unit = "update-containers.service";
      OnCalendar = "Mon 02:00";
    };
    wantedBy = [ "timers.target" ];
  };
  systemd.services.update-containers = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.getExe (pkgs.writeShellScriptBin "update-containers" ''
        images=$(${pkgs.podman}/bin/podman ps -a --format="{{.Image}}" | sort -u)
       	for image in $images; do
          ${pkgs.podman}/bin/podman pull "$image"
       	done
       	${pkgs.podman}/bin/podman restart --all
      '');
    };
  };
}
