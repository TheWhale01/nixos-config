#!/usr/bin/env bash

print_help() {
    local cmd
    cmd=$(basename "$0")
    cat <<EOF
    "${cmd}" <action>
    ...valid actions are...
        c -- <c>lose lid
        o -- <o>pen lid
EOF
}

assign_workspaces() {
    local monitors
    local idx
    monitors=$(hyprctl monitors -j | jq -r 'map(select(.disabled == false)) | sort_by(.x) | .[].name')
    idx=1
    for monitor in $monitors; do
        hyprctl keyword workspace "$idx,monitor:$monitor"
        hyprctl dispatch moveworkspacetomonitor "$idx $monitor"
        ((idx++))
    done
}

case $1 in
    c | -c)
        hyprctl keyword monitor "eDP-1, disable"
        # assign_workspaces
    ;;
    o | -o)
        hyprctl keyword monitor "eDP-1, 2880x1920, 0x0, 1.5"
        # assign_workspaces
    ;;
    *)
        print_help
    ;;
esac
