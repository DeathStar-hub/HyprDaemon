# Weather Widget Reproduction Guide

This guide provides exact steps to reproduce the enhanced weather widget with 7 radar sources, colored menu, and all features.

## 📋 Prerequisites

- **System**: Arch Linux with Hyprland, Waybar, Kitty
- **Dependencies**: curl, jq, brave-browser (or chromium)
- **Theme**: Omarchy with any theme (affects terminal colors)
- **Hardware**: CPU temperature sensor (coretemp/k10temp/zenpower)

## 📁 Files Required

Copy these files from `~/AI/config/`:

```
waybar/
├── config.jsonc          # Waybar configuration with weather module
├── style.css             # Styling (transparent bar)
└── scripts/
    ├── weather.sh        # Main weather script (API, tooltips, click handlers)
    ├── weather-detailed.sh # 3-day forecast popup script
    └── radar-menu.sh     # Floating radar menu script

hyprland/
└── hyprland.conf         # Hyprland config with floating window rules
```

**Key Updates in Final Version**:
- **weather.sh**: Enhanced tooltip with emoji icons, middle-click opens MSN Weather
- **config.jsonc**: 23px height, workspace 10 support, improved module configs
- **style.css**: Clean styling without custom font overrides

## 🚀 Step-by-Step Setup

### Option 1: Automated Setup (Recommended)

```bash
cd ~/AI
./setup.sh
```

This script will:
- Copy waybar config, styles, and scripts to `~/.config/waybar/`
- Copy hyprland config to `~/.config/hypr/`
- Set executable permissions on scripts
- Check for required dependencies (curl, jq, brave)
- Display success message with next steps

### Option 2: Manual Setup

```bash
# 1. Copy waybar configuration files
cp ~/AI/config/waybar/config.jsonc ~/.config/waybar/
cp ~/AI/config/waybar/style.css ~/.config/waybar/

# 2. Copy weather scripts
cp ~/AI/config/waybar/scripts/weather.sh ~/.config/waybar/scripts/
cp ~/AI/config/waybar/scripts/weather-detailed.sh ~/.config/waybar/scripts/
cp ~/AI/config/waybar/scripts/radar-menu.sh ~/.config/waybar/scripts/

# 3. Copy hyprland configuration
cp ~/AI/config/hyprland/hyprland.conf ~/.config/hypr/

# 4. Make scripts executable
chmod +x ~/.config/waybar/scripts/weather.sh
chmod +x ~/.config/waybar/scripts/weather-detailed.sh
chmod +x ~/.config/waybar/scripts/radar-menu.sh
```

### 2. Verify Waybar Configuration

Ensure `~/.config/waybar/config.jsonc` contains the weather module:

```jsonc
"custom/weather": {
  "exec": "~/.config/waybar/scripts/weather.sh",
  "return-type": "json",
  "interval": 1800,
  "on-click": "~/.config/waybar/scripts/weather.sh click",
  "on-click-middle": "~/.config/waybar/scripts/weather.sh middle-click",
  "on-click-right": "~/.config/waybar/scripts/weather.sh right-click"
}
```

And ensure `~/.config/hypr/hyprland.conf` contains the floating window rules:

```conf
# Weather radar menu floating window
windowrulev2 = float, title:radar-menu
windowrulev2 = size 45% 45%, title:radar-menu
windowrulev2 = center, title:radar-menu
```

**Note**: The parameters must be `left`, `middle`, and `right` (not `click`, `middle-click`, `right-click`) to match the script's case statement.

### 2.1. Updated Waybar Configuration Features

The latest config from `~/AI/config/waybar/config.jsonc` includes:

- **Height**: 23px (smaller profile)
- **Enhanced workspace icons**: Includes workspace 10 with "0" icon
- **Improved modules**: Updated bluetooth, CPU, and temperature configurations
- **Better font rendering**: Uses FiraCode Nerd Font for consistency
- **Weather widget**: Fixed click parameters for proper functionality

### 3. Test the Widget

```bash
# Restart services
hyprctl reload
pkill waybar && waybar

# Verify weather module appears in waybar
# Hover over weather icon: Shows tooltip with temp, humidity, wind, condition
# Left-click: Opens kitty popup with 3-day forecast details
# Middle-click: Opens MSN weather page in browser
# Right-click: Opens floating radar menu (40% x 50% window, centered)
```

### 3.1. Enhanced Tooltip Features

The weather widget now includes:

- **Main Display**: Weather emoji icon + temperature (e.g., "☁️ -9.6°C")
- **Hover Tooltip**: 
  ```
  🌡️ Temperature: -9.6°C
  💧 Humidity: 88%
  💨 Wind: 7.8 km/h W
  ☁️ Condition: Overcast
  ```
- **No Location Text**: Removed "Weather in Whitecourt, AB" for cleaner display
- **Emoji Icons**: Added to each tooltip line for better visual appeal

### 4. Verify Radar Menu

Right-click the weather widget should open a kitty terminal with:

```
🌤️  Fetching detailed weather for Whitecourt...
═══════════════════════════════════════════════════════════════

1. 🌧️ RainViewer - Global radar (recommended)
2. 🌪️ Windy - Interactive weather map
3. 📡 AccuWeather - Local radar
4. 🌤️ MSN Weather - Whitecourt forecast
5. 📰 CTV News - Edmonton weather
6. 📰 Global News - Edmonton weather
7. 🛰️ Environment Canada - Western Canada satellite

8. 🚀 Open all weather sources

Enter choice (1-8):
```

**Menu Links** (opens in Brave browser):
1. 🌧️ https://www.rainviewer.com/weather-radar-map-live.html
2. 🌪️ https://www.windy.com/?53.862,-116.899,8
3. 📡 https://www.accuweather.com/en/ca/whitecourt/t7s/weather-radar/51942
4. 🌤️ https://www.msn.com/en-ca/weather/forecast/in-Whitecourt,AB?loc=eyJsIjoiV2hpdGVjb3VydCIsInIiOiJBQiIsInIyIjoiRGl2aXNpb24gMTMiLCJjIjoiQ2FuYWRhIiwiaSI6IkNBIiwiZyI6ImVuLWNhIiwieCI6Ii0xMTUuNjg1NDkzNDY5MjM4MjgiLCJ5IjoiNTQuMTUwMTUwMjk5MDcyMjY2In0%3D&weadegreetype=C
5. 📰 https://www.ctvnews.ca/edmonton/weather/
6. 📰 https://globalnews.ca/edmonton/weather/CAXX0126
7. 🛰️ https://weather.gc.ca/satellite/satellite_anim_e.html?sat=goes&area=wcan&type=1070

**Expected behavior**:
- **Floating window**: Menu appears as a centered floating window (45% screen size)
- Numbers are colored (red, green, yellow, blue, magenta, cyan, white, red)
- Selecting 1-7 opens individual radar sites in default browser
- Selecting 8 opens all 7 sites with 0.5s delays to prevent blocking
- Menu closes immediately after selection, browser opens after

### 5. Verify Detailed Popup

Left-click should open a kitty popup with:

```
📍 CURRENT CONDITIONS
   Temperature: XX.X°C
   Conditions: [Weather]
   Humidity: XX%
   Wind: X.X km/h [Direction]
   Precip chance: X%

📅 TODAY'S FORECAST
   High: XX.X°C  |  Low: XX.X°C
   Conditions: [Weather]
   Precipitation: X.XX mm

📅 TOMORROW
   [Similar format]

📅 [Day after]
   [Similar format]

🌐 Online: https://windy.com/?latitude=54.15&longitude=-115.68

Press any key to close...
```

### 6. Troubleshooting

**Menu not showing colors?**
- Ensure terminal supports ANSI colors
- Check if `echo -e` works in your shell

**Browser not opening?**
- Verify Brave is installed and default browser
- Check `xdg-settings get default-web-browser` returns `brave-browser.desktop`

**Scripts not found?**
- Verify paths: `~/.config/waybar/scripts/weather.sh`
- Check permissions: `ls -la ~/.config/waybar/scripts/`

**Waybar not loading?**
- Check logs: `journalctl -u waybar` or run `waybar` in terminal for errors
- Ensure height is 34px in config.jsonc

**Temperature not showing?**
- Check if hwmon7 exists: `ls /sys/class/hwmon/hwmon7/`
- If not, find your CPU sensor: `for i in /sys/class/hwmon/hwmon*/name; do echo "$(basename $(dirname $i)): $(cat $i)"; done`
- Update the hwmon-path in `~/.config/waybar/config.jsonc` temperature module
- Common paths: hwmon0/coretemp, hwmon1/k10temp, hwmon2/zenpower

**Floating menu not appearing?**
- Check hyprland config has: `windowrulev2 = float, title:radar-menu`
- Verify kitty is installed: `which kitty`
- Test manually: `kitty --title radar-menu ~/.config/waybar/scripts/radar-menu.sh`

**Menu appears but browser not opening on selection?**
- Ensure xdg-open works: `xdg-open https://example.com`
- Check default browser: `xdg-settings get default-web-browser`
- If using kitty with background &, the environment may not pass correctly; remove & from kitty command in weather.sh
- Move browser opening to weather.sh after menu closes by writing URLs to /tmp/weather_choice
- For option 8, add 0.5s delays between xdg-open calls to prevent browser blocking

**Browser not opening?**
- Verify default browser: `xdg-settings get default-web-browser`
- Set if needed: `xdg-settings set default-web-browser brave-browser.desktop`
- Test xdg-open: `xdg-open https://example.com`

**Weather data not loading?**
- Check internet: `curl -s "https://api.open-meteo.com/v1/forecast?latitude=54.15&longitude=-115.68&current_weather=true"`
- Verify jq installed: `jq --version`

**Script changes not applying?**
- **IMPORTANT**: Always restart Waybar after editing scripts: `pkill waybar && waybar &`
- Waybar caches scripts in memory and won't reload changes automatically
- Test scripts directly first: `~/.config/waybar/scripts/weather.sh right`

**Option 8 (Open all) not working?**
- Ensure browser supports multiple tabs
- Check if `xdg-open` is working: `xdg-open https://example.com`
- Script now includes delays to prevent browser blocking

## 🔧 Manual Testing

Test individual components:

```bash
# Test weather display
~/.config/waybar/scripts/weather.sh

# Test detailed popup
~/.config/waybar/scripts/weather.sh left

# Test radar menu
~/.config/waybar/scripts/weather.sh right

# Test middle-click
~/.config/waybar/scripts/weather.sh middle
```

## 📊 Features Summary

- **Real-time weather** from Open-Meteo API
- **7 radar sources** with direct links
- **Colored terminal menu** with icons
- **3-day forecast popup** with detailed info
- **Browser integration** with Brave
- **Location**: Whitecourt, AB (54.15°N, -115.68°W)

## 📝 Notes

- All URLs are tested and working as of 2025-11-30
- Menu uses kitty terminal for consistent display
- Browser tabs open in background for smooth experience
- System uses Celsius and km/h units
- **Emoji Icons**: Weather widget uses emoji icons in both bar and tooltip
- **Middle-click**: Opens MSN Weather for Whitecourt (not Windy)
- **Tooltip**: Enhanced with emoji icons for each weather parameter
- **Font**: Uses system FiraCode Nerd Font for consistent theming
- **Window Size**: 45% floating window for optimal readability
- **Browser Opening**: Uses temp file method to ensure proper environment for xdg-open
- **Delays**: 0.5s between tabs for option 8 to prevent browser blocking

## 🔄 Final Reproduction Checklist

1. **Copy Files**: Use `~/AI/config/waybar/` files (updated versions)
2. **Set Permissions**: `chmod +x ~/.config/waybar/scripts/weather.sh`
3. **Restart Waybar**: `pkill waybar && waybar`
4. **Test Features**:
   - ✅ Bar shows: "☁️ -9.6°C" (weather icon + temp)
   - ✅ Hover shows: Emoji icons + weather details
   - ✅ Left-click: Detailed weather popup
   - ✅ Middle-click: MSN Weather (Whitecourt)
    - ✅ Right-click: 7-source radar menu with colors (45% floating window)
    - ✅ Option 8: Opens all weather sources with delays

If issues persist, compare file contents with `~/AI/config/waybar/` and ensure no local modifications.

## 🔧 Final Working Configuration

### Hyprland Window Rules
```conf
# Weather radar menu floating window
windowrulev2 = float, title:radar-menu
windowrulev2 = size 45% 45%, title:radar-menu
windowrulev2 = center, title:radar-menu
```

### Waybar Configuration (weather module)
```jsonc
"custom/weather": {
  "exec": "~/.config/waybar/scripts/weather.sh",
  "return-type": "json",
  "interval": 1800,
  "on-click": "~/.config/waybar/scripts/weather.sh left",
  "on-click-middle": "~/.config/waybar/scripts/weather.sh middle",
  "on-click-right": "~/.config/waybar/scripts/weather.sh right"
}
```

### Key Script Changes
- Removed `&` from kitty command in `weather.sh` right-click handler
- Moved `xdg-open` calls from `radar-menu.sh` to `weather.sh` using temp file `/tmp/weather_choice`
- Added 0.5s delays between `xdg-open` calls for option 8
- Set initial kitty window size to 600x400 pixels
- Menu closes immediately after selection, browser opens after