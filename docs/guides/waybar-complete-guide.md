# Complete Waybar Setup Guide

**Last Updated**: 2026-01-07
**Status**: ✅ **Fully Configured & Reproducible**

---

## 📋 Overview

This document provides a complete, turnkey setup for all Waybar customizations including:
- ✅ **CPU Sparkline** - Dual sparkline showing usage and frequency
- ✅ **GPU Sparkline** - Load percentage and frequency monitoring
- ✅ **Weather Widget** - Full interactivity with radar sources
- ✅ **Battery Widget** - Charge, power, and time remaining with idle control

---

## 🚀 Quick Start (Turnkey Setup)

### Option 1: Copy Complete Configuration
```bash
# Copy all waybar files
cp -r ~/AI/config/waybar/* ~/.config/waybar/

# Make scripts executable
chmod +x ~/.config/waybar/scripts/*.sh

# Restart waybar
pkill waybar && waybar &
```

### Option 2: Use Setup Script
```bash
cd ~/AI
./setup.sh
```

---

## 📊 Module Layout

### Left Side
```
[] [👁] [workspaces] [CPU ▅▆▇▅ ▄▂▃▁] [📊▄▅▃▆]
```
- **** - Omarchy menu (Super+Alt+Space)
- **👁** - Toggle waybar visibility
- **workspaces** - Hyprland workspaces with icons
- **CPU ▅▆▇▅ ▄▂▃▁** - CPU usage (top) and frequency (bottom) sparklines
- **📊▄▅▃▆** - GPU load sparkline

### Center
```
[clock] [update] [screenrecording]
```
- **clock** - Time and date (right-click for timezone)
- **update** - Omarchy update indicator
- **screenrecording** - Recording indicator

### Right Side
```
[weather] [tray] [temp] [bt] [net] [audio] [cpu] [battery]
```
- **weather** - Weather with temperature
- **tray** - System tray (click to expand)
- **temp** - CPU temperature
- **bt** - Bluetooth status
- **net** - Network connection
- **audio** - Pulseaudio volume
- **cpu** - CPU icon (click for btop)
- **battery** - Battery with charge and time

---

## 🔧 Custom Modules

### 1. CPU Sparkline (`custom/cpu-spark`)

**Script**: `~/.config/waybar/scripts/cpu-spark.sh`

**Output**:
```json
{"text":"▅▆▇▅ ▄▂▃▁","tooltip":"CPU: 45% | Freq: 2400 MHz"}
```

**Features**:
- Dual sparklines: usage (top) and frequency (bottom)
- 4-point rolling history
- Updates every 2 seconds
- Hover tooltip with percentage and MHz

**How it works**:
- Reads `/proc/stat` for CPU usage
- Reads `/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq` for frequency
- Calculates usage percentage from difference between samples
- Maps values to 8-level unicode blocks (▁▂▃▄▅▆▇█)

**Troubleshooting**:
```bash
# Test manually
~/.config/waybar/scripts/cpu-spark.sh

# Should output JSON with sparklines
```

---

### 2. GPU Sparkline (`custom/gpu-spark`)

**Script**: `~/.config/waybar/scripts/gpu-spark.sh`

**Output**:
```json
{"text":"📊 ▄▅▃▆","tooltip":"GPU: 77% | 817 MHz"}
```

**Features**:
- Single sparkline showing GPU load
- Shows current frequency in MHz
- 4-point rolling history
- Updates every 2 seconds
- Icon: 📊 (chart/graph)

**Hardware Support**:
- **Intel Integrated Graphics**: Tested with Intel HD Graphics 530
- **AMD Radeon**: Partial support (frequency only, temperature unavailable)
- **NVIDIA**: Not tested (would need nvidia-smi)

**How it works**:
- Reads `/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt_cur_freq_mhz` for current frequency
- Reads `rps_max_freq_mhz` for maximum frequency
- Calculates load percentage: `(current / max) * 100`
- Maps to 8-level sparkline blocks

**Troubleshooting**:
```bash
# Test manually
~/.config/waybar/scripts/gpu-spark.sh

# If showing "Checking...", check GPU path:
find /sys -name "gt_cur_freq_mhz" 2>/dev/null

# For NVIDIA GPUs, you'd need to modify script to use nvidia-smi
```

**Customization**:
To support different GPUs, edit the script and add paths:
```bash
# AMD Radeon
if [[ -f "/sys/class/drm/card1/device/pp_dpm_sclk" ]]; then
    FREQ_MHZ=$(grep "*" /sys/class/drm/card1/device/pp_dpm_sclk | grep -oE '[0-9]+Mhz' | sed 's/Mhz//')
fi

# NVIDIA
if command -v nvidia-smi &> /dev/null; then
    FREQ_MHZ=$(nvidia-smi --query-gpu=clocks.gr --format=csv,noheader,nounits | tr -d ' ')
fi
```

---

### 3. Weather Widget (`custom/weather`)

**Script**: `~/.config/waybar/scripts/weather.sh`

**Output**:
```json
{"text":"☀️ -5.2°C","tooltip":"📍 Whitecourt: -5.2°C\n💧 Humidity: 70%\n💨 Wind: 7.8 km/h W\n☁️ Condition: Clear sky"}
```

**Features**:
- Current temperature with weather icon
- 30-minute update interval (1800 seconds)
- **Left Click**: Opens detailed weather popup with 3-day forecast
- **Middle Click**: Opens Windy.com radar for Whitecourt, AB
- **Right Click**: Interactive radar menu with 7 sources
- **Hover**: Current conditions display

**Weather Provider**:
- **API**: Open-Meteo (free, no API key required)
- **Location**: Whitecourt, AB (54.15, -115.68)
- **Data**: Temperature, humidity, wind, weather code

**Click Actions**:

**Left Click** (Detailed Popup):
```bash
~/.config/waybar/scripts/weather.sh left
# Opens kitty terminal with detailed 3-day forecast
```

**Middle Click** (Windy Radar):
```bash
~/.config/waybar/scripts/weather.sh middle
# Opens Windy.com radar in browser
```

**Right Click** (Radar Menu):
```bash
~/.config/waybar/scripts/weather.sh right
# Opens fancy terminal menu with 7 radar sources:
# 1. RainViewer
# 2. Windy
# 3. AccuWeather
# 4. Environment Canada
# 5. Ventusky
# 6. Meteologix
# 7. The Weather Channel
```

**Weather Icons**:
```
0  = ☀️  # Clear sky
1  = 🌤️  # Mainly clear
2  = ⛅   # Partly cloudy
3  = ☁️  # Overcast
45 = 🌫️  # Fog
51-55 = 🌦️  # Drizzle
61-65 = 🌧️  # Rain
71-75 = 🌨️  # Snow
95-99 = ⛈️  # Thunderstorm
```

**Troubleshooting**:
```bash
# Test weather script
~/.config/waybar/scripts/weather.sh

# Check internet connection
ping -c 1 api.open-meteo.com

# View detailed forecast
~/.config/waybar/scripts/weather.sh left

# Test radar menu
~/.config/waybar/scripts/weather.sh right
```

**Customization**:
To change location, edit `weather.sh`:
```bash
# Change coordinates
LAT="54.15"
LON="-115.68"
CITY="Your City"
```

---

### 4. Battery Widget (`custom/battery`)

**Script**: `~/.config/waybar/scripts/custom-battery.sh`

**Output**:
```json
{"text":"󰁹","tooltip":"90% 13.0W↓ | 3.1h"}
```

**Features**:
- Battery icon based on charge level (10 levels)
- Power consumption in watts (↑ charging, ↓ discharging)
- Time remaining from upower estimates
- Idle pause indicator (⏸️) when timeouts are paused
- **Left Click**: Opens power menu
- **Middle Click**: Opens idle timeout control menu (fzf)
- **Right Click**: Opens battery history graph

**Battery Icons**:
```
Charging: 󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅
Discharging: 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹
Full: 󰂅
```

**Idle Timeout Control**:
Right-click to pause idle timeouts:
- 5 minutes
- 10 minutes
- 30 minutes
- 1 hour
- Indefinitely
- Resume with countdown

**Battery History Graph**:
```bash
~/.config/waybar/scripts/battery-graph.sh
# Opens kitty terminal with dual graph:
# - Top: Capacity line chart
# - Bottom: Power consumption bars
```

**How it works**:
- Reads `/sys/class/power_supply/BAT0/` for capacity and status
- Calculates power from `power_now`, `current_now`, `voltage_now`
- Uses `upower -i` for time estimates
- Checks `idle-controller.sh` for pause status

**Troubleshooting**:
```bash
# Test battery script
~/.config/waybar/scripts/custom-battery.sh

# Check battery device
ls /sys/class/power_supply/

# View time estimate
upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "time to"

# Test idle control
~/.config/waybar/scripts/sleep-interrupt-menu.sh

# View battery history
~/.config/waybar/scripts/battery-graph.sh
```

---

## 📁 File Structure

```
~/.config/waybar/
├── config.jsonc              # Main waybar configuration
├── style.css                 # Waybar styling
└── scripts/
    ├── cpu-spark.sh          # CPU dual sparkline
    ├── gpu-spark.sh          # GPU load sparkline
    ├── weather.sh            # Weather widget with radar
    ├── custom-battery.sh     # Battery with idle control
    ├── battery-graph.sh      # Battery history graph
    ├── sleep-interrupt-menu.sh    # Idle timeout control
    ├── idle-controller.sh    # Idle pause/resume
    ├── weather-detailed.sh   # Detailed weather popup
    ├── weather-radar-menu.sh    # Radar source menu
    ├── waybar-toggle.sh     # Toggle visibility
    └── radar-menu.sh        # Interactive radar selection
```

---

## 🔍 Debugging

### Check Waybar Status
```bash
# View waybar logs
journalctl --user -u waybar -f

# Test config syntax
waybar --config ~/.config/waybar/config.jsonc --dry-run

# Restart waybar
pkill waybar && waybar &
```

### Test Individual Scripts
```bash
# CPU
~/.config/waybar/scripts/cpu-spark.sh

# GPU
~/.config/waybar/scripts/gpu-spark.sh

# Weather
~/.config/waybar/scripts/weather.sh

# Battery
~/.config/waybar/scripts/custom-battery.sh
```

### Common Issues

**Module not showing**:
1. Check script is executable: `chmod +x script.sh`
2. Test script manually
3. Check waybar logs: `journalctl --user -u waybar`

**Incorrect paths**:
1. Use `~/.config/` instead of `/home/username/.config/`
2. No double `.config/.config/` paths

**Weather not updating**:
1. Check internet connection
2. Verify Open-Meteo API is accessible
3. Test script manually

**GPU not working**:
1. Check GPU path: `find /sys -name "gt_cur_freq_mhz"`
2. Modify script for different GPU hardware
3. Test script manually

---

## 📚 Related Documentation

- **Weather Widget**: See `~/AI/projects/hypr/weather-widget.md`
- **Battery History**: See `~/AI/battery-history-widget/README.md`
- **Waybar Troubleshooting**: See `~/AI/projects/hypr/waybar-troubleshooting.md`
- **CPU Frequency Enhancement**: See `~/AI/cpu-frequency-enhancement.md`
- **Idle Timeout Control**: See `~/AI/idle-timeout-control.md`

---

## ✅ Status Checklist

- ✅ CPU sparkline working
- ✅ GPU sparkline working
- ✅ Weather widget working with all click actions
- ✅ Battery widget working with idle control
- ✅ All scripts executable
- ✅ Configuration synced to `~/AI/config/waybar/`
- ✅ Documentation complete
- ✅ Ready for multi-system sync

---

**Version**: 1.0
**Last Updated**: 2026-01-07
**Author**: AI Assistant
**License**: Same as Omarchy project
