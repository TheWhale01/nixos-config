{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 18;
      window-padding-x = 25;
      window-padding-y = 25;
    };
  };
}
