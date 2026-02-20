#!/bin/bash
# FIX BROKEN WEATHER WIDGET - Remove broken click handlers
echo "Fixing weather widget by removing broken click handlers..."

# Copy simple working version
cp /home/nemesis/AI/projects/hypr/weather-simple-working.sh /home/nemesis/.config/waybar/scripts/weather.sh
chmod +x /home/nemesis/.config/waybar/scripts/weather.sh

# Remove broken click handlers from config
sed -i '/on-click.*weather/,+2d' /home/nemesis/.config/waybar/config.jsonc

# Reload waybar
killall -SIGUSR2 waybar

echo "Weather widget fixed! No more broken click handlers."