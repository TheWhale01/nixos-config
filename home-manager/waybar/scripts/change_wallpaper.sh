HYPR_DIR=$HOME/.config/hypr
WALLPAPER_DIR=${HYPR_DIR}/wallpapers
CURRENT_WALLPAPER=$(hyprctl hyprpaper listloaded)

wallpapers=()

# Get available wallpapers
for wallpaper in ${WALLPAPER_DIR}/*; do
	wallpapers+=("${wallpaper}")
done

write_hyprlock_config() {
	echo "
background {
	monitor =
	path = $1
	blur_passes = 2
}
	" > ${HYPR_DIR}/hyprlock/background.conf
}

write_hyprpaper_config() {
	echo "Changing wallpaper for $1"
	echo "preload = $1" > ${HYPR_DIR}/hyprpaper.conf
	echo "wallpaper = , $1" >> ${HYPR_DIR}/hyprpaper.conf
	write_hyprlock_config "$1"
	hyprctl hyprpaper reload ,"$1"
}

change_wallpaper() {
	write_hyprpaper_config "$1"
	python3 ${HYPR_DIR}/app_conf/waybar/scripts/crop.py "$1"
	cp "$1" "/usr/share/sddm/themes/eucalyptus-drop/Backgrounds/background.jpg"
}

# Check if last wallpaper is selected or if none is loaded
if [ "${CURRENT_WALLPAPER}" == "${wallpapers[-1]}" ] || [ "${CURRENT_WALLPAPER}" == "no wallpapers loaded" ]; then
	change_wallpaper "${wallpapers[0]}"
	exit $?
fi

i=0
while [[ $i -lt ${#wallpapers[@]} ]]; do
	wallpaper=${wallpapers[$i]}
	if [[  ${wallpaper} == ${CURRENT_WALLPAPER} ]]; then
		break
	fi
	((i+=1))
done
((i+=1))
change_wallpaper "${wallpapers[$i]}"
