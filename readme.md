# NixOS

This repo contains all my nixos configurations for laptop / desktops / servers.
I'm learning while making this repo so please don't be too harsh !

 - erebos (server conf.)
 - pontos (laptop conf.)
 - olympos (desktop conf.)
 - strategos (raspberry conf.)

For setting up one of these configs, you should have `flakes` enabled:

```nix
# /etc/configuration.nix
{
	nix.settings.experimental-features = [
		"nix-command"
		"flakes"
	];
}
```

or if you are on the NixOS installer:

```bash
# Clone the repo
# Go into the repo
git checkout <erebos|pontos|olympos|strategos>

# if disko.nix file present
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./sys/disko.nix

sudo nixos-install --flake .#<erebos|pontos|olympos|strategos>
```

> __*NOTE:*__ Feel free to change the disko config according to your hardware
