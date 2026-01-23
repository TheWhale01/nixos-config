{ ... }:

# Possible to have a button to change the wallpaper ?
# https://github.com/hyprwm/hyprpaper
# Wallpaper set by stylix
let
  files = builtins.attrNames (builtins.readDir ./wallpapers);
  allWallpapers = map(fileName: "${./wallpapers}/${fileName}") files;
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      preload = allWallpapers;
      wallpaper = [{
        monitor = "";
        path = "${./wallpapers/wallpaper.png}";
        fit_mode = "cover";
      }];
    };
  };
}
