{ inputs, ... }:

{
  imports = [
    inputs.modules.nixosModules.default
    ./direnv.nix
  ];

  programs.home-manager.enable = true;
}
