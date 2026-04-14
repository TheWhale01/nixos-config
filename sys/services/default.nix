{ ... }:

{
  imports = [
    ./pipewire.nix
    ./xserver.nix
    ./fwupd.nix
    ./blueman.nix
    ./print.nix
    ./keyring.nix
    ./fprintd.nix
    ./power-profiles.nix
    ./ollama.nix
    ./flatpak.nix
  ];
}
