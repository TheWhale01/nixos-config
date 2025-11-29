{ ... }:

{
  services.create_ap = {
    enable = true;
    settings = {
      INTERNET_IFACE = "enu1u1u1";
      WIFI_IFACE = "wlan0";
      SSID = "Chambre Hugo";
      PASSPHRASE = "12345678";
    };
  };
}
