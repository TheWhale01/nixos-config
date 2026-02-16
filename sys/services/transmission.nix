{ config, pkgs, ... }:

let
  vpnName = "proton";
  traefik-vars = (import ../vars.nix).traefik;
  protonNatPmpScript = pkgs.writeScriptBin "proton-natpmp" ''
    #!${pkgs.runtimeShell}

    # 1. Credentials Setup
    # We need to read the password to talk to Transmission
    # This assumes your Agenix secret is a JSON file like: { "rpc-username": "...", "rpc-password": "..." }
    # If your secret is just "username:password", change the parsing below.
    SECRETS="${config.age.secrets.transmission.path}"

    # Try to extract user/pass. If jq fails, these will be empty.
    TR_USER=$(${pkgs.jq}/bin/jq -r '."rpc-username"' "$SECRETS")
    TR_PASS=$(${pkgs.jq}/bin/jq -r '."rpc-password"' "$SECRETS")
    AUTH_FLAG=""

    if [ ! -z "$TR_USER" ] && [ "$TR_USER" != "null" ]; then
      AUTH_FLAG="-n $TR_USER:$TR_PASS"
    fi

    # 2. The Loop
    while true; do
      echo "Asking ProtonVPN for a port..."

      # Ask Proton Gateway (10.2.0.1) for a port with 60s lifetime
      # We ask for both TCP and UDP
      NAT_RESPONSE=$(${pkgs.libnatpmp}/bin/natpmpc -a 1 0 udp 60 -g 10.2.0.1)

      # Extract the port number
      PORT=$(echo "$NAT_RESPONSE" | grep 'Mapped public port' | ${pkgs.busybox}/bin/awk -F' ' '{print $4}' | head -n 1)

      if [ -z "$PORT" ]; then
        echo "ERROR: Could not get a port from ProtonVPN! Retrying in 10s..."
        sleep 10
        continue
      fi

      echo "ProtonVPN assigned port: $PORT"

      # 3. Update Transmission
      # We check if the port actually changed to avoid spamming logs
      CURRENT_PORT=$(${pkgs.transmission_4}/bin/transmission-remote $AUTH_FLAG -si | grep 'Listening port:' | ${pkgs.busybox}/bin/awk '{print $3}')

      if [ "$CURRENT_PORT" != "$PORT" ]; then
        echo "Updating Transmission port from $CURRENT_PORT to $PORT..."
        ${pkgs.transmission_4}/bin/transmission-remote $AUTH_FLAG -p "$PORT"

        # Verify
        if [ $? -eq 0 ]; then
          echo "SUCCESS: Transmission is now listening on port $PORT"
        else
          echo "FAILED: Could not update Transmission settings."
        fi
      else
        echo "Port has not changed. Standing by..."
      fi

      # 4. Sleep (Proton requires renewal every 60s, so we sleep 45s to be safe)
      sleep 45
    done
  '';
in
{
  services.transmission = {
    enable = true;
    group = "media";
    package = pkgs.transmission_4;
    webHome = pkgs.flood-for-transmission;
    settings = {
      rpc-enabled = true;
      rpc-authentication-required = true;
      rpc-whitelist-enabled = false;
      incomplete-dir-enabled = false;
      encryption = 2;
      web-ui = "flood";
      peer-port-random-on-start = false;
      peer-port-random-low = 49152;
      peer-port-random-high = 65535;
      download-dir = "/data/downloads";
      umask = "002";
      rpc-bind-address = "0.0.0.0"; # Bind RPC/WebUI to VPN network namespace address
      rpc-whitelist = "192.168.15.1,192.168.1.*,127.0.0.1";
    };
    credentialsFile = "${config.age.secrets.transmission.path}";
    downloadDirPermissions = "775";
    openRPCPort = false;
    openPeerPorts = false;
  };
  services.traefik.dynamicConfigOptions.http = {
    services.transmission.loadBalancer.servers = [
      {
        url = "http://192.168.15.1:${toString config.services.transmission.settings.rpc-port}";
      }
    ];
    routers.transmission = {
      rule = "Host(`transmission.${traefik-vars.domain}`)";
      tls = true;
      service = "transmission";
      entrypoints = "websecure";
    };
  };
}
