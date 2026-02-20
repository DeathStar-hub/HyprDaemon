#!/usr/bin/env bash
# ~/.config/waybar/scripts/gpu-toggle.sh

STATE_FILE="/tmp/waybar_gpu_mode"
AMD_VENDOR="0x1002"
INTEL_VENDOR="0x8086"

# Initialize state if not exists
if [[ ! -f "$STATE_FILE" ]]; then
    echo "I" > "$STATE_FILE"
fi

# Handle arguments
case "$1" in
    toggle)
        current=$(cat "$STATE_FILE")
        if [[ "$current" == "I" ]]; then
            echo "D" > "$STATE_FILE"
            pkill -RTMIN+11 waybar
        else
            echo "I" > "$STATE_FILE"
            pkill -RTMIN+11 waybar
        fi
        ;;
    launch)
        app="$2"
        current=$(cat "$STATE_FILE")
        if [[ "$current" == "D" ]]; then
            DRI_PRIME=1 $app &
        else
            $app &
        fi
        ;;
    *)
        # Just output current state
        cat "$STATE_FILE"
        ;;
esac
