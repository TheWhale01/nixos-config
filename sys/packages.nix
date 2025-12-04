{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    git
    nixd
    nil
    basedpyright
    ruff
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
    mailutils
    dig
  ];
}
