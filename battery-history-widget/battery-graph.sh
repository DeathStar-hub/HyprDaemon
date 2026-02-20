#!/bin/bash
# Battery power history graph using gnuplot
# Shows battery history since boot

LOG_FILE="$HOME/.cache/battery_history.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "No battery history available. Start logging with battery-log.sh"
    read -n 1
    exit 1
fi

if ! command -v gnuplot &> /dev/null; then
    echo "gnuplot not found. Install with: paru -S gnuplot"
    read -n 1
    exit 1
fi

# Get boot time
BOOT_TIME=$(date -d "$(uptime -s)" +%s)
NOW=$(date +%s)
UPTIME_MINUTES=$(( (NOW - BOOT_TIME) / 60 ))

# Determine display range (use uptime, capped at 30)
DISPLAY_MINUTES=$UPTIME_MINUTES
if [ $DISPLAY_MINUTES -gt 30 ]; then
    DISPLAY_MINUTES=30
fi
if [ $DISPLAY_MINUTES -lt 1 ]; then
    DISPLAY_MINUTES=1
fi

# Create temporary data file for gnuplot
DATA_FILE=$(mktemp)
POWER_FILE=$(mktemp)

# Extract data since boot
tail -n 60 "$LOG_FILE" | awk -v boot_time="$BOOT_TIME" -v now="$NOW" '
{
    if ($1 >= boot_time) {
        minutes_ago = int((now - $1) / 60)
        if (minutes_ago >= 0 && minutes_ago <= 30) {
            # For capacity graph: minutes_ago (x), capacity (y)
            # Reverse so left is oldest
            print (30 - minutes_ago), $3 > "/dev/stderr"
            # For power data: minutes_ago, watts
            print minutes_ago, $2
        }
    }
}' 2>"$DATA_FILE" > "$POWER_FILE"

# Display capacity line graph
echo "🔋 Battery Capacity Line Graph (Since Boot - Last $DISPLAY_MINUTES min)"
echo "═══════════════════════════════════════════════════════════════"
echo ""

gnuplot -p << EOF
set terminal dumb size 80,12
set xlabel "Time ago (minutes)"
set ylabel "Battery %"
set xrange [0:30]
set yrange [80:100]
set ytics 5
set xtics 5
set nokey
set grid
plot "$DATA_FILE" with lines lw 1
EOF

echo ""
echo ""
echo "⚡ Battery Power Consumption (Since Boot - Last $DISPLAY_MINUTES min)"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Sort power data by minutes_ago (newest first)
sort -n -k1 -r "$POWER_FILE" | awk '{
    watts = $2
    watts_int = int(watts * 40 / 30)
    if (watts_int > 40) watts_int = 40
    if (watts_int < 0) watts_int = 0
    
    bar = ""
    for (i = 0; i < watts_int; i++) bar = bar "█"
    for (i = watts_int; i < 40; i++) bar = bar " "
    
    printf "%2dm ago: |%-40s| %.2fW\n", $1, bar, watts
}'

# Cleanup
rm -f "$DATA_FILE" "$POWER_FILE"

echo ""
echo "Press any key to close..."
read -n 1
