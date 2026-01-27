{ ... }:

{
  imports = [
    ../../modules/neovim.nix
    ../../modules/btop.nix
    ../../modules/git.nix
    ../../modules/zsh.nix
    ./direnv.nix
  ];

  programs.home-manager.enable = true;
}
