#// Check if wlogout is already running

if pgrep -x "wlogout" >/dev/null; then
    pkill -x "wlogout"
    exit 0
fi

#// set file variables

confDir="${confDir:-$HOME/nix/home-manager/wlogout}"
wlTmplt="${confDir}/style.css"

#// detect monitor res
x_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
y_mon=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .height')
hypr_scale=$(hyprctl -j monitors | jq '.[] | select (.focused == true) | .scale' | sed 's/\.//')

#// scale config layout and style
export x_mgn=$((x_mon * 35 / hypr_scale))
export y_mgn=$((y_mon * 25 / hypr_scale))
export x_hvr=$((x_mon * 32 / hypr_scale))
export y_hvr=$((y_mon * 20 / hypr_scale))

#// scale font size
export fntSize=$((y_mon * 2 / 100))

#// eval hypr border radius
hypr_border="${hypr_border:-10}"
export active_rad=$((hypr_border * 5))
export button_rad=$((hypr_border * 8))

#// Get the nix-store path of wlogout for icons
export wlogoutPath=$(nix-instantiate --eval-only --expr '(import <nixpkgs> {}).wlogout.outPath' | tr -d '"')

#// eval config files
wlStyle="$(envsubst <"${wlTmplt}")"
# echo "${wlStyle}" > ~/test.css

#// launch wlogout
wlogout -b 2 -c 0 -r 0 -m 0 --layout $HOME/.config/wlogout/layout --css <(echo "${wlStyle}") --protocol layer-shell
