{ pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		vim
		git
		pyright
		nixd
		nil
		typescript-language-server
		tailscale
		fastfetch
		ripgrep
		tree
		nvtopPackages.nvidia
		pciutils
		unzip
		tmux
		nvidia-container-toolkit
		jq
	];
}
