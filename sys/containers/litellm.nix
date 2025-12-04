{ config, ... }:

let
  username = "litellm";
  password = "";
in
{
  virtualisation.oci-containers.containers."litellm" = {
    image = "ghcr.io/berriai/litellm:main-latest";
    environment = {
      DATABASE_URL = "postgresql://${username}:${password}@127.0.0.1:${toString config.services.postgresql.settings.port}/litellm";
    };
    environmentFiles = [
      config.age.secrets.litellm.path
    ];
    extraOptions = [ "--network=host" ];
  };
}
