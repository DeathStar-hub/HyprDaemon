# Weather Widget Project

## Overview
Fixed waybar weather widget that was showing "N/A" and enhanced it with weather icons.

## Problem
- Weather widget in waybar was displaying "N/A" instead of current weather
- Original provider (wttr.in) was not responding to requests
- Missing weather condition icons (sun, clouds, etc.)

## Solution
- Replaced wttr.in with Open-Meteo API (free, no API key required)
- Added weather condition icons based on WMO weather codes
- Enhanced display to show both icon and temperature

## Files Modified
- `~/.config/waybar/scripts/weather.sh` - Main weather script
- `~/.config/waybar/config.jsonc` - Waybar configuration (referenced)

## Technical Details

### Weather Provider
- **Old**: wttr.in (http://wttr.in/Whitecourt?format=%c+%t)
- **New**: Open-Meteo API (https://api.open-meteo.com/v1/forecast)
- **Coordinates**: Whitecourt, AB (54.15, -115.68)
- **API Response**: Temperature, weather code, wind speed, direction, day/night

### Weather Icons Mapping
```bash
0  = ☀️  # Clear sky
1  = 🌤️  # Mainly clear
2  = ⛅   # Partly cloudy
3  = ☁️  # Overcast
45 = 🌫️  # Fog
48 = 🌫️  # Depositing rime fog
51-55 = 🌦️  # Drizzle variations
56-57 = 🌧️  # Freezing drizzle
61-65 = 🌧️  # Rain variations
66-67 = 🌨️  # Freezing rain
71-75 = 🌨️  # Snow variations
77 = 🌨️  # Snow grains
80-82 = 🌦️  # Rain showers
85-86 = 🌨️  # Snow showers
95-99 = ⛈️  # Thunderstorm variations
```

### Script Output Format
- **Format**: JSON with text and tooltip
- **Example**: `{"text":"🌤️ -6.9°C","tooltip":"Weather in Whitecourt"}`
- **Update Interval**: 1800 seconds (30 minutes)

## Implementation Steps
1. Investigated current weather script and identified wttr.in failure
2. Tested Open-Meteo API successfully
3. Updated weather script with new API and icon mapping
4. Made script executable
5. Tested script functionality
6. Reloaded waybar to apply changes

## Current Status
✅ **COMPLETED WITH FULL INTERACTIVE FEATURES** - Weather widget working with icons and comprehensive actions
- Shows current temperature with appropriate weather icon
- Updates every 30 minutes
- Reliable API connection
- Clean JSON output for waybar integration
- **NEW**: Three-click actions with radar menu and location-specific links

## Interactive Features
- **Left Click**: Opens detailed weather popup with 3-day forecast
- **Middle Click**: Opens Windy.com radar specifically for Whitecourt, AB
- **Right Click**: Interactive radar menu with 7 options in fancy terminal display
- **Hover**: Clean current conditions display
- **Detailed Popup**: Shows current conditions, humidity, wind
- **Radar Menu**: 7 radar sources (RainViewer, Windy, AccuWeather, Environment Canada, Ventusky, Meteologix, The Weather Channel)

## Dependencies
- curl (for API requests)
- jq (for JSON parsing)
- kitty (for terminal popup display)
- xdg-open (for opening web browser)
- Internet connection for weather data

## Files Modified/Added
- `~/.config/waybar/scripts/weather.sh` - Enhanced with click handlers
- `~/.config/waybar/scripts/weather-detailed.sh` - New detailed weather popup script
- `~/.config/waybar/config.jsonc` - Added click event handlers

## Future Enhancements
- Add location switching capability
- Support for multiple locations
- Weather alerts integration
- Customizable popup themes