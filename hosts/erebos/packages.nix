{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		vim
		git
		pyright
		nixd
		typescript-language-server
		tailscale
		fastfetch
		ripgrep
		tree
		nvtopPackages.nvidia
		pciutils
		unzip
		tmux
	];
}
