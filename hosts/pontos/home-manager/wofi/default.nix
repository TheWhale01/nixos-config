{ ... }:

{
  programs.wofi = {
    enable = true;
    style = ./style.css;
    settings = {
      allow_images = true;
      image_size = 40;
    };
  };
}
