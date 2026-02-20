#!/usr/bin/env bash
# ~/.config/waybar/scripts/custom-battery.sh

BAT_NAME=$(ls /sys/class/power_supply/ | grep '^BAT' | head -1)
if [[ -z "$BAT_NAME" ]]; then
    echo '{"text": "No BAT", "tooltip": "No battery detected"}'
    exit 0
fi
BAT_PATH="/sys/class/power_supply/$BAT_NAME"

capacity=$(cat "$BAT_PATH/capacity")
status=$(cat "$BAT_PATH/status")

if [[ "$status" == "Charging" ]]; then
    icons=("󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")
elif [[ "$status" == "Full" ]]; then
    icon="󰂅"
else
    icons=("󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
fi

if [[ "$status" != "Full" ]]; then
    idx=$(( capacity / 10 ))
    if (( idx > 9 )); then idx=9; fi
    icon="${icons[$idx]}"
fi

if [[ -z "$icon" ]]; then
    icon="󰁹"
fi

power_now=$(cat "$BAT_PATH/power_now" 2>/dev/null || echo "0")
if (( power_now == 0 )); then
    current_now=$(cat "$BAT_PATH/current_now" 2>/dev/null || echo "0")
    voltage_now=$(cat "$BAT_PATH/voltage_now" 2>/dev/null || echo "0")
    if (( current_now > 0 && voltage_now > 0 )); then
        power_now=$(( current_now * voltage_now / 1000000 ))
    fi
fi
power_w=$(echo "scale=1; $power_now / 1000000" | bc 2>/dev/null || echo "0.0")

time_formatted=""
if [[ "$status" == "Discharging" ]] || [[ "$status" == "Charging" ]]; then
    time_to_empty=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 2>/dev/null | grep -E "time to (empty|full):" | awk '{print $4, $5}')
    if [[ -n "$time_to_empty" ]]; then
        time_formatted=$(echo "$time_to_empty" | awk '{if ($2 ~ /hour/) printf "%.1fh", $1; else if ($2 ~ /minute/) printf "%.0fm", $1}')
    fi
fi

idle_status=$(~/.config/waybar/scripts/idle-controller.sh status)
text="${icon}"
if [[ -n "$idle_status" ]]; then
    text="⏸️ ${icon}"
fi

if [[ "$status" == "Discharging" ]]; then
    tooltip="${power_w}W↓"
    [[ -n "$time_formatted" ]] && tooltip+=" | ${time_formatted}"
elif [[ "$status" == "Charging" ]]; then
    tooltip="${power_w}W↑"
    [[ -n "$time_formatted" ]] && tooltip+=" | ${time_formatted}"
else
    tooltip="${power_w}W (${status})"
fi

if [[ -n "$idle_status" ]]; then
    tooltip+="\nIdle Paused: ${idle_status}"
fi

echo "{\"text\": \"${text}\", \"tooltip\": \"${capacity}% ${tooltip}\"}"
