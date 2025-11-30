{ ... }:

let
  users = [
    {
      name = "vaultwarden";
      ensureDBOwnership = true;
    }
    {
      name = "litellm";
      ensureDBOwnership = true;
    }
    {
      name = "nextcloud";
      ensureDBOwnership = true;
    }
    {
      name = "paperless";
      ensureDBOwnership = true;
    }
    {
      name = "replicator";
    }
  ];
  databases = [
    "vaultwarden"
    "litellm"
    "nextcloud"
    "paperless"
  ];
in
{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    authentication = ''
       			host  all all 127.0.0.1/32    trust
       			host  all all ::1/128         trust
       			local all all                 trust
       			host replication replicator 192.168.1.153/32 md5
      		'';
    settings = {
      wal_level = "replica";
      max_wal_senders = 5;
      max_replication_slots = 5;
      hot_standby = "off";
    };
    ensureUsers = users;
    ensureDatabases = databases;
  };
}
