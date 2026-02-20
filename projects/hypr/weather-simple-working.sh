#!/usr/bin/env bash
# SIMPLE WORKING WEATHER WIDGET - NO CLICK HANDLERS
city="Whitecourt"
lat="54.15"
lon="-115.68"

get_weather_icon() {
    case $1 in
        0) echo "☀️" ;; 1) echo "🌤️" ;; 2) echo "⛅" ;; 3) echo "☁️" ;;
        45) echo "🌫️" ;; 48) echo "🌫️" ;;
        51) echo "🌦️" ;; 53) echo "🌦️" ;; 55) echo "🌦️" ;;
        56) echo "🌧️" ;; 57) echo "🌧️" ;;
        61) echo "🌧️" ;; 63) echo "🌧️" ;; 65) echo "🌧️" ;;
        66) echo "🌨️" ;; 67) echo "🌨️" ;;
        71) echo "🌨️" ;; 73) echo "🌨️" ;; 75) echo "🌨️" ;;
        77) echo "🌨️" ;;
        80) echo "🌦️" ;; 81) echo "🌦️" ;; 82) echo "🌦️" ;;
        85) echo "🌨️" ;; 86) echo "🌨️" ;;
        95) echo "⛈️" ;; 96) echo "⛈️" ;; 99) echo "⛈️" ;;
        *) echo "🌡️" ;;
    esac
}

response=$(curl -m 10 -s "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=relativehumidity_2m,windspeed_10m,winddirection_10m&temperature_unit=celsius")

if [ -n "$response" ]; then
    temp=$(echo "$response" | jq -r '.current_weather.temperature')
    code=$(echo "$response" | jq -r '.current_weather.weathercode')
    icon=$(get_weather_icon "$code")
    data="${icon} ${temp}°C"
    
    humidity=$(echo "$response" | jq -r '.hourly.relativehumidity_2m[0]')
    wind_speed=$(echo "$response" | jq -r '.hourly.windspeed_10m[0]')
    wind_dir=$(echo "$response" | jq -r '.hourly.winddirection_10m[0]')
    
    # Simple wind direction
    wind_dir_int=$(echo "$wind_dir" | cut -d. -f1)
    if [ "$wind_dir_int" -ge 338 ] || [ "$wind_dir_int" -lt 23 ]; then wind_card="N"
    elif [ "$wind_dir_int" -ge 23 ] && [ "$wind_dir_int" -lt 68 ]; then wind_card="NE"
    elif [ "$wind_dir_int" -ge 68 ] && [ "$wind_dir_int" -lt 113 ]; then wind_card="E"
    elif [ "$wind_dir_int" -ge 113 ] && [ "$wind_dir_int" -lt 158 ]; then wind_card="SE"
    elif [ "$wind_dir_int" -ge 158 ] && [ "$wind_dir_int" -lt 203 ]; then wind_card="S"
    elif [ "$wind_dir_int" -ge 203 ] && [ "$wind_dir_int" -lt 248 ]; then wind_card="SW"
    elif [ "$wind_dir_int" -ge 248 ] && [ "$wind_dir_int" -lt 293 ]; then wind_card="W"
    else wind_card="NW"; fi
    
    tooltip="${icon} ${city}
🌡️  Temperature: ${temp}°C
💧  Humidity: ${humidity}%
💨  Wind: ${wind_speed} km/h ${wind_card}"
else
    data="N/A"
    tooltip="Weather in ${city} - N/A"
fi

printf '{"text":"%s","tooltip":"%s"}\n' "$data" "$tooltip"