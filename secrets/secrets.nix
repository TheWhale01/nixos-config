let
	# SSH keys used to encrypt secrets
	erebos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQ/GL8RjU7lnxKb9YTzbdsO0O5KhMBwlbVwDZgY2LWb";
in
{
	"transmission.json".publicKeys = [ erebos ];
	"nextcloud.age".publicKeys = [ erebos ];
	"litellm.age".publicKeys = [ erebos ];
	"traefik/cf_dns_token.age".publicKeys = [ erebos ];
}
