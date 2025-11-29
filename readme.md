# NixOS

This repo contains all my nixos configurations for laptop / desktops / servers.
I'm learning while making this repo so please don't be too harsh !

 - erebos (server conf.)
 - pontos (laptop conf.)
 - olympos (desktop conf.)

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
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./hosts/<erebos|pontos|olympos>/disko.nix
sudo nixos-install --flake .#<erebos|pontos|olympos>
```

> __*NOTE:*__ Feel free to change the disko config according to your hardware

## Todo

Some things are left to do to have something fully secured while having this publicly available.

### Erebos
1. How to build my blog stack ?
2. Setup litellm
3. Remove option to login with password via SSH

### Pontos
1. Add public key to erebos

### Olympos
everything needs to be done
