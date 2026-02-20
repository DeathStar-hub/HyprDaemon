#!/bin/bash
# ~/.config/hypr/scripts/autoclip.sh
# Auto-copy daemon for clipboard management

# Copy primary selection to clipboard automatically
/usr/bin/wl-paste -p --watch /usr/bin/wl-copy &

# Store clipboard history with cliphist
/usr/bin/wl-paste --watch /usr/bin/cliphist store &

# Keep the script running
wait