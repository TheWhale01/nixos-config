{ ... }:

let
  traefik-vars = (import ../vars.nix).traefik;
in
{
  services.postfix = {
    enable = true;
    hostname = "${traefik-vars.domain}";
    domain = "${traefik-vars.domain}";
    origin = "${traefik-vars.domain}";
    enableSubmission = true;
    enableSmtp = true;
    networksStyle = "host";
    extraConfig = ''
      inet_protocols = ipv4
      smtp_tls_security_level = may
      smtp_tls_loglevel = 1
      smtpd_recipient_restrictions = permit_mynetworks, reject_unauth_destination
    '';
  };
}
