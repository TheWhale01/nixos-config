{
  traefik = {
    domain = "thewhale.fr";
    dns_provider = "cloudflare";
  };
  lidarr = {
    port = 8686;
  };
  aurral = {
    port = 3001;
  };
  spotiflac = {
    port = 6890;
  };
  nextcloud = {
    port = 8881;
    office = {
      port = 9980;
    };
  };
  openbooks = {
    port = 8081;
  };
  maintainerr = {
    port = 6246;
  };
  transmission = {
    port = 9091;
    flood = {
      port = 3002;
    };
  };
  anaisbuche = {
    port = 8002;
  };
  jellyfin = {
    port = 8096;
  };
  authentik = {
    port = 9000;
  };
  matrix = {
    port = 8008;
    user = "matrix-synapse";
    group = "matrix-synapse";
  };
  mas = {
    user = "mas";
    group = "mas";
  };
}
