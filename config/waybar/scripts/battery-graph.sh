#!/bin/bash
# Battery power history graph
# Shows last 30 minutes as ASCII bar graph and line graph

LOG_FILE="$HOME/.cache/battery_history.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "No battery history available. Start logging with battery-log.sh"
    read -n 1
    exit 1
fi

# Get current power status
CURRENT_WATTS=$(tail -1 "$LOG_FILE" | awk '{print $2}')
CURRENT_PERCENT=$(tail -1 "$LOG_FILE" | awk '{print $3}')
STATUS_FILE="/sys/class/power_supply/BAT0/status"
if [ -f "$STATUS_FILE" ]; then
    CURRENT_STATUS=$(cat "$STATUS_FILE")
else
    CURRENT_STATUS="Unknown"
fi

# Get system power profile
SYSTEM_PROFILE=$(powerprofilesctl get 2>/dev/null || echo "unknown")

# Map system profile to emoji
case "$SYSTEM_PROFILE" in
    "performance")
        PROFILE_EMOJI="🚀"
        PROFILE_NAME="Performance"
        ;;
    "balanced")
        PROFILE_EMOJI="⚖️"
        PROFILE_NAME="Balanced"
        ;;
    "power-saver")
        PROFILE_EMOJI="🌱"
        PROFILE_NAME="Power Saver"
        ;;
    *)
        PROFILE_EMOJI="❓"
        PROFILE_NAME="Unknown"
        ;;
esac

# Determine power profile
if [ "$CURRENT_STATUS" = "Charging" ]; then
    POWER_PROFILE="⚡ Charging ${PROFILE_EMOJI}${PROFILE_NAME} (${CURRENT_WATTS}W)"
elif [ "$CURRENT_STATUS" = "Discharging" ]; then
    POWER_PROFILE="🔋 Discharging ${PROFILE_EMOJI}${PROFILE_NAME} (${CURRENT_WATTS}W)"
elif [ "$CURRENT_STATUS" = "Full" ]; then
    POWER_PROFILE="🔋 Fully Charged ${PROFILE_EMOJI}${PROFILE_NAME} (${CURRENT_WATTS}W)"
else
    POWER_PROFILE="📊 ${CURRENT_STATUS} ${PROFILE_EMOJI}${PROFILE_NAME} (${CURRENT_WATTS}W)"
fi

# Display capacity line graph FIRST (on top)
echo "🔋 Battery Capacity: ${CURRENT_PERCENT}% (Last 30 minutes)"
echo "═══════════════════════════════════════════════════════════════"

# Create smooth dotted line graph - filter by time, limit to 30 entries
awk -v now="$(date +%s)" '
{
    timestamp = $1
    capacity = $3
    minutes_ago = int((now - timestamp) / 60)
    
    # Only use data from last 30 minutes
    if (minutes_ago <= 30) {
        print timestamp, minutes_ago, capacity
    }
}' "$LOG_FILE" | sort -n | awk '
BEGIN {
    count = 0
}
{
    timestamp = $1
    minutes_ago = $2
    capacity = $3
    
    times[count] = minutes_ago
    values[count] = capacity
    count++
}
END {
    if (count == 0) exit
    
    # Check if any values are outside 50-100 range
    need_lower = 0
    for (i = 0; i < count; i++) {
        if (values[i] < 50) {
            need_lower = 1
            break
        }
    }
    
    # Set scale based on data range
    if (need_lower) {
        max_scale = 100
        min_scale = 0
        rows = 10
    } else {
        max_scale = 100
        min_scale = 50
        rows = 10
    }
    
    # Create graph with dots positioned by time with tighter spacing
    for (row = rows; row >= 0; row--) {
        line = ""
        for (col = 0; col < count; col++) {
            # Scale value to graph rows
            scaled = int((values[col] - min_scale) / (max_scale - min_scale) * rows)
            if (scaled < 0) scaled = 0
            if (scaled > rows) scaled = rows
            
            if (scaled == row) {
                line = line "● "
            } else {
                line = line "  "
            }
        }
        printf "%3d%% %s\n", min_scale + (max_scale - min_scale) * row / rows, line
    }
    
    # Add time axis - show every few points with tighter spacing
    axis = ""
    for (i = 0; i < count; i++) {
        if (i % 2 == 0 || i == count-1) {
            axis = axis sprintf("%-2d", times[i])
        } else {
            axis = axis "  "
        }
    }
    printf "     %s (min ago)\n", axis
}'

echo ""
echo "🔋 Battery Power Profile: $POWER_PROFILE"
echo "═══════════════════════════════════════════════════════════════"
echo ""
echo "📊 Power Consumption History (Last 30 minutes)"
echo "═══════════════════════════════════════════════════════════════"

# Display power consumption bars LAST (on bottom) - filter by time, limit to 30 entries
awk -v now="$(date +%s)" '
{
    timestamp = $1
    watts = $2
    capacity = $3
    minutes_ago = int((now - timestamp) / 60)
    
    # Only use data from last 30 minutes
    if (minutes_ago <= 30) {
        print timestamp, minutes_ago, watts
    }
}' "$LOG_FILE" | sort -n | awk '
{
    timestamp = $1
    minutes_ago = $2
    watts = $3
    
    # Create bar (scale watts to 0-20 chars)
    watts_int = int(watts)
    if (watts_int > 20) watts_int = 20
    
    bar = ""
    for (i = 0; i < watts_int; i++) {
        bar = bar "█"
    }
    for (i = watts_int; i < 20; i++) {
        bar = bar "░"
    }
    
    printf "%2dm ago: %s %.2fW\n", minutes_ago, bar, watts
}'

echo ""
echo ""
echo -e "\033[1;1H"  # Move cursor to top-left (scroll to top)
read -n 1 -s -r -p ""
