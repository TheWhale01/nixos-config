{ ... }:

{
  services.gnome.gnome-keyring = {
    enable = true;
  };
  security.pam.services = {
    login = {
      enableGnomeKeyring = true;
    };
    gdm-password = {
      enableGnomeKeyring = true;
    };
    systemd-user = {
      enableGnomeKeyring = true;
    };
  };
}
