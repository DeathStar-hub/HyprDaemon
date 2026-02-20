# Weather Widget Backup & Recovery

## Original Working Setup (Pre-Enhancement)

### Files Backed Up:
- `~/.config/waybar/scripts/weather.sh.backup` - Original working script
- `~/.config/waybar/config.jsonc.backup` - Original waybar config

### Original Script Content:
```bash
# ~/.config/waybar/scripts/weather.sh
#!/usr/bin/env bash
# Requires: curl, jq
# Using Open-Meteo API (free, no API key required)
city="Whitecourt"
# Coordinates for Whitecourt, AB
lat="54.15"
lon="-115.68"

# Weather code to icon mapping
get_weather_icon() {
    case $1 in
        0) echo "☀️" ;;  # Clear sky
        1) echo "🌤️" ;;  # Mainly clear
        2) echo "⛅" ;;   # Partly cloudy
        3) echo "☁️" ;;   # Overcast
        45) echo "🌫️" ;; # Fog
        48) echo "🌫️" ;; # Depositing rime fog
        51) echo "🌦️" ;; # Drizzle: Light
        53) echo "🌦️" ;; # Drizzle: Moderate
        55) echo "🌦️" ;; # Drizzle: Dense
        56) echo "🌧️" ;; # Freezing Drizzle: Light
        57) echo "🌧️" ;; # Freezing Drizzle: Dense
        61) echo "🌧️" ;; # Rain: Slight
        63) echo "🌧️" ;; # Rain: Moderate
        65) echo "🌧️" ;; # Rain: Heavy
        66) echo "🌨️" ;; # Freezing Rain: Light
        67) echo "🌨️" ;; # Freezing Rain: Heavy
        71) echo "🌨️" ;; # Snow fall: Slight
        73) echo "🌨️" ;; # Snow fall: Moderate
        75) echo "🌨️" ;; # Snow fall: Heavy
        77) echo "🌨️" ;; # Snow grains
        80) echo "🌦️" ;; # Rain showers: Slight
        81) echo "🌦️" ;; # Rain showers: Moderate
        82) echo "🌦️" ;; # Rain showers: Violent
        85) echo "🌨️" ;; # Snow showers: Slight
        86) echo "🌨️" ;; # Snow showers: Heavy
        95) echo "⛈️" ;; # Thunderstorm: Slight or moderate
        96) echo "⛈️" ;; # Thunderstorm with slight hail
        99) echo "⛈️" ;; # Thunderstorm with heavy hail
        *) echo "🌡️" ;; # Default/Unknown
    esac
}

response=$(curl -m 10 -s "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&temperature_unit=celsius")

if [ -n "$response" ]; then
    temp=$(echo "$response" | jq -r '.current_weather.temperature')
    code=$(echo "$response" | jq -r '.current_weather.weathercode')
    icon=$(get_weather_icon "$code")
    data="${icon} ${temp}°C"
else
    data="N/A"
fi

printf '{"text":"%s","tooltip":"Weather in %s"}\n' "$data" "$city"
```

### Original Waybar Config:
```json
  "custom/weather": {
    "exec": "~/.config/waybar/scripts/weather.sh",
    "return-type": "json",
    "interval": 1800
  },
```

## Recovery Instructions

### To Restore Original Working Weather Widget:

1. **Restore the original script:**
   ```bash
   cp ~/.config/waybar/scripts/weather.sh.backup ~/.config/waybar/scripts/weather.sh
   ```

2. **Restore the original config:**
   ```bash
   cp ~/.config/waybar/config.jsonc.backup ~/.config/waybar/config.jsonc
   ```

3. **Reload waybar:**
   ```bash
   killall -SIGUSR2 waybar
   ```

### If Backup Files Are Missing:

1. **Create the original script:**
   ```bash
   cat > ~/.config/waybar/scripts/weather.sh << 'EOF'
   [Paste original script content from above]
   EOF
   chmod +x ~/.config/waybar/scripts/weather.sh
   ```

2. **Edit waybar config to remove click handlers:**
   ```bash
   # Remove these lines from custom/weather section:
   "on-click": "~/.config/waybar/scripts/weather.sh click",
   "on-click-middle": "~/.config/waybar/scripts/weather.sh middle-click"
   ```

3. **Reload waybar:**
   ```bash
   killall -SIGUSR2 waybar
   ```

## Enhanced Version Features

### What Was Added:
- Left-click: Detailed weather popup
- Middle-click: Open Windy.com
- Enhanced tooltip with action hints
- 3-day forecast in popup
- Wind direction and humidity details

### New Files Created:
- `~/.config/waybar/scripts/weather-detailed.sh` - Detailed popup script

### Dependencies Added:
- `kitty` - For terminal popup
- `xdg-open` - For opening web browser

## Troubleshooting

### If Weather Widget Disappears:
1. Check script syntax: `~/.config/waybar/scripts/weather.sh`
2. Check waybar logs: `journalctl --user -u waybar --since "5 minutes ago"`
3. Test script manually: `~/.config/waybar/scripts/weather.sh`
4. Restore from backup if needed

### If Click Actions Don't Work:
1. Check if dependencies are installed: `which kitty xdg-open`
2. Test click actions manually:
   - Left click: `~/.config/waybar/scripts/weather.sh click`
   - Middle click: `~/.config/waybar/scripts/weather.sh middle-click`

---
**Backup Date**: 2025-11-29  
**Enhancement Date**: 2025-11-29  
**Status**: Backups created and tested