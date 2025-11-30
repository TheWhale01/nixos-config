{ ... }:

{
  services.postgresql = {
    enable = true;
    settings = {
        hot_standby = "on";
        primary_conninfo = "host=192.168.1.154 user=replicator password=bonsoir";
        primary_slot_name = "nextcloud_slot";
    };
  };
}
