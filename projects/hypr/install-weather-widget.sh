#!/bin/bash
# ONE COMMAND SETUP - Just run this to install working weather widget
echo "Installing complete weather widget..."

# Copy the working script
cp /home/nemesis/AI/projects/hypr/weather-widget-complete.sh /home/nemesis/.config/waybar/scripts/weather.sh
chmod +x /home/nemesis/.config/waybar/scripts/weather.sh

# Reload waybar
killall -SIGUSR2 waybar

echo "Weather widget installed with enhanced hover!"
echo "Hover over it to see temperature, humidity, and wind details."