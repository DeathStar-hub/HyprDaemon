#!/bin/bash
# AI System Setup Script
# Reproduces the complete system configuration

set -e

echo "🚀 Starting AI System Reproduction..."
echo "====================================="

# Check if we're in the right directory
if [ ! -f "weather-widget-reproduction.md" ]; then
    echo "❌ Error: Run this script from the ~/AI directory"
    exit 1
fi

# Create config directories if they don't exist
echo "📁 Creating config directories..."
mkdir -p ~/.config/waybar/scripts
mkdir -p ~/.config/hypr
mkdir -p ~/.config/kitty
mkdir -p ~/.config/omarchy

# Replace hardcoded usernames in configs with current user
echo "🔄 Adapting configs to current user ($USER)..."
USER_HOME="/home/$USER"
find config/ -type f \( -name "*.conf" -o -name "*.jsonc" -o -name "*.sh" \) -exec sed -i "s|/home/nemesis/|$USER_HOME/|g" {} +
find config/ -type f \( -name "*.conf" -o -name "*.jsonc" -o -name "*.sh" \) -exec sed -i "s|/home/tokka/|$USER_HOME/|g" {} +
find config/ -type f -name "*.sh" -exec sed -i 's|/home/[^/]/|~/.config/|g' {} +

# Copy waybar configs
echo "📊 Copying Waybar configuration..."
cp config/waybar/config.jsonc ~/.config/waybar/
cp config/waybar/style.css ~/.config/waybar/

# Copy scripts
echo "🔧 Copying scripts..."
cp config/waybar/scripts/weather.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/weather-detailed.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/radar-menu.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/weather-radar-menu.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/cpu-spark.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/gpu-spark.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/custom-battery.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/sleep-interrupt-menu.sh ~/.config/waybar/scripts/
cp config/waybar/scripts/idle-controller.sh ~/.config/waybar/scripts/
cp battery-history-widget/battery-log.sh ~/.config/waybar/scripts/
cp battery-history-widget/battery-graph.sh ~/.config/waybar/scripts/

# Copy hyprland configs
echo "🖥️  Copying Hyprland configuration..."
cp -r config/hypr/* ~/.config/hypr/

# Copy kitty configuration
echo "🐱 Copying Kitty configuration..."
cp config/kitty.conf ~/.config/kitty/

# Copy ranger file associations
echo "📝 Copying Ranger configuration..."
mkdir -p ~/.config/ranger
cp config/ranger/rifle.conf ~/.config/ranger/

# NOTE: Omarchy menu script is provided by omarchy package itself
# It lives in ~/.local/share/omarchy/bin/omarchy-menu and is managed by omarchy
# Do not copy custom versions there - only customize files in ~/.config/

# NOTE: Kitty config includes omarchy themes via ~/.config/omarchy/current/theme/kitty.conf
# Window padding and settings are now reproducible via config/kitty.conf
# NOTE: Omarchy theme files in ~/.local/share/omarchy/ are managed by omarchy itself
# Do not copy there - only customize files in ~/.config/

# Ranger file associations configured:
#   • Text files → kate
#   • Image files → imv
#   • Video files → mpv

# Copy systemd user services
echo "🔋 Setting up battery logging..."
mkdir -p ~/.config/systemd/user
cp battery-history-widget/battery-log.timer ~/.config/systemd/user/
cp battery-history-widget/battery-log.service ~/.config/systemd/user/
systemctl --user enable battery-log.timer
systemctl --user start battery-log.timer

# Kitty and Omarchy menu configs now included for full menu styling reproducibility.

# Set permissions
echo "🔑 Setting permissions..."
chmod +x ~/.config/waybar/scripts/weather.sh
chmod +x ~/.config/waybar/scripts/weather-detailed.sh
chmod +x ~/.config/waybar/scripts/radar-menu.sh
chmod +x ~/.config/waybar/scripts/weather-radar-menu.sh
chmod +x ~/.config/waybar/scripts/cpu-spark.sh
chmod +x ~/.config/waybar/scripts/gpu-spark.sh
chmod +x ~/.config/waybar/scripts/custom-battery.sh
chmod +x ~/.config/waybar/scripts/sleep-interrupt-menu.sh
chmod +x ~/.config/waybar/scripts/idle-controller.sh
chmod +x ~/.config/waybar/scripts/battery-log.sh
chmod +x ~/.config/waybar/scripts/battery-graph.sh
# omarchy-menu script is provided by omarchy package in ~/.local/share/omarchy/bin/

# Check dependencies
echo "🔍 Checking dependencies..."
missing_deps=()
command -v curl >/dev/null 2>&1 || missing_deps+=("curl")
command -v jq >/dev/null 2>&1 || missing_deps+=("jq")
command -v bc >/dev/null 2>&1 || missing_deps+=("bc")
command -v brave >/dev/null 2>&1 || missing_deps+=("brave-browser")
command -v kitty >/dev/null 2>&1 || missing_deps+=("kitty")
command -v waybar >/dev/null 2>&1 || missing_deps+=("waybar")
command -v hyprctl >/dev/null 2>&1 || missing_deps+=("hyprland")
command -v omarchy-menu >/dev/null 2>&1 || missing_deps+=("omarchy")  # omarchy-menu is provided by omarchy package

if [ ${#missing_deps[@]} -ne 0 ]; then
    echo "⚠️  Missing dependencies: ${missing_deps[*]}"
    echo "Install with: paru -S ${missing_deps[*]}"
else
    echo "✅ All dependencies found"
fi

echo ""
echo "🎉 Setup complete!"
echo "=================="
echo "Next steps:"
echo "1. Restart Hyprland: hyprctl reload"
echo "2. Restart Waybar: pkill waybar && waybar"
echo "3. Test weather widget right-click menu"
echo "4. Test battery widget right-click for history graph"
echo "5. Test battery widget middle-click for sleep interrupt menu"
echo "6. Test power menu (Super+Shift+P) - Shutdown should be first option"
echo ""
echo "🔧 Window Characteristics Included:"
echo "  • Sleep interrupt menu: 28% x 35% size, centered, floating, styled"
echo "  • Battery history graph: 70% x 50% size, centered, floating"
echo "  • Weather radar menu: 45% x 45% size, floating, centered"
echo "  • All window rules automatically configured"
echo ""
echo "📋 Menu Customizations Included:"
echo "  • Power menu: Shutdown moved to top (default selection)"
echo "  • Ranger file associations: Text→kate, Images→imv, Videos→mpv"
echo ""
echo "IMPORTANT: Always restart Waybar after editing scripts!"
echo "See weather-widget-reproduction.md, battery-history-widget/README.md, and idle-timeout-control.md for details"