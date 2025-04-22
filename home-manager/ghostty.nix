{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 18;
      font-synthetic-style = "bold";
      window-padding-x = 25;
      window-padding-y = 25;
    };
  };
}
