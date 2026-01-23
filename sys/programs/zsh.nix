{ ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      docker="podman";
    };
  };
}
