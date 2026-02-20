#!/bin/bash
# Battery power logging script
# Logs watts consumption every minute

LOG_FILE="$HOME/.cache/battery_history.log"

# Get battery power and capacity
CURRENT_FILE="/sys/class/power_supply/BAT0/current_now"
VOLTAGE_FILE="/sys/class/power_supply/BAT0/voltage_now"
CAPACITY_FILE="/sys/class/power_supply/BAT0/capacity"

if [ -f "$CURRENT_FILE" ] && [ -f "$VOLTAGE_FILE" ] && [ -f "$CAPACITY_FILE" ]; then
    # Calculate power: P = V * I (both in micro units)
    CURRENT_UA=$(cat "$CURRENT_FILE")
    VOLTAGE_UV=$(cat "$VOLTAGE_FILE")
    POWER_UW=$((CURRENT_UA * VOLTAGE_UV / 1000000))  # Convert to microwatts
    POWER_W=$(echo "scale=2; $POWER_UW / 1000000" | bc)
    CAPACITY=$(cat "$CAPACITY_FILE")
    TIMESTAMP=$(date +%s)
    echo "$TIMESTAMP $POWER_W $CAPACITY" >> "$LOG_FILE"

    # Keep only last 1000 entries (about 16 hours at 1/min)
    tail -n 1000 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
fi