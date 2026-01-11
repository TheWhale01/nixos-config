{ ... }:

{
  virtualisation.oci-containers.containers."minenix" = {
    image = "itzg/minecraft-server:latest";
    volumes = [
      "/var/lib/minenix:/data"
    ];
    environment = {
      EULA = "TRUE";        # Required to run the server
      TYPE = "PAPER";       # "PAPER" is faster than "VANILLA". Other = FORGE, FABRIC
      VERSION = "LATEST";   # Or specify a version like "1.20.1"
      MEMORY = "4G";        # RAM allocation
    };
    extraOptions = [
      "--network=host"
    ];
  };
  systemd.tmpfiles.rules = [
    "d /var/lib/minenix 0755 root root - -"
  ];
}
