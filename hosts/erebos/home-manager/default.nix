{ ... }:

{
	imports = [
		../../../modules/neovim.nix
		../../../modules/btop.nix
		../../../modules/git.nix
		../../../modules/zsh.nix
	];

	programs.home-manager.enable = true;
}
