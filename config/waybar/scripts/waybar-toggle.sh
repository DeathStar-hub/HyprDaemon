#!/usr/bin/env bash
# ~/.config/waybar/scripts/waybar-toggle.sh
# Toggles waybar visibility (Super+B)

STATE_FILE="/tmp/waybar_toggle_$USER"

# Toggle waybar
case "$1" in
    toggle)
        if pgrep -x waybar > /dev/null; then
            pkill waybar
            echo "off" > "$STATE_FILE"
        else
            waybar &
            echo "on" > "$STATE_FILE"
        fi
        ;;
    *)
        # Just output current state as JSON with icon
        state=$(cat "$STATE_FILE" 2>/dev/null || echo "on")
        if [[ "$state" == "on" ]]; then
            icon="👁"
        else
            icon="👁"
        fi
        printf '{"text":"%s","tooltip":"Waybar: %s"}\n' "$icon" "$state"
        ;;
esac
