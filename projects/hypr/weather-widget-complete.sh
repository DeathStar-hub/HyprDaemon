#!/usr/bin/env bash
# Complete working weather widget with enhanced hover
# Just copy this file - no reinvention needed

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
    
    # Simple wind direction without floating point issues
    wind_dir_int=$(echo "$wind_dir" | cut -d. -f1)
    case $wind_dir_int in
        0|22|23|33[89]|34[0-9]|35[0-9]) wind_card="N" ;;
        2[3-9]|3[0-9]|4[0-9]|5[0-9]|6[0-7]) wind_card="NE" ;;
        6[8-9]|7[0-9]|8[0-9]|9[0-9]|10[0-9]|11[0-2]) wind_card="E" ;;
        11[3-9]|12[0-9]|13[0-9]|14[0-9]|15[0-7]) wind_card="SE" ;;
        15[8-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9]|20[0-2]) wind_card="S" ;;
        20[3-9]|21[0-9]|22[0-9]|23[0-9]|24[0-7]) wind_card="SW" ;;
        24[8-9]|25[0-9]|26[0-9]|27[0-9]|28[0-9]|29[0-2]) wind_card="W" ;;
        *) wind_card="NW" ;;
    esac
    
    tooltip="${icon} ${city}
🌡️  Temperature: ${temp}°C
💧  Humidity: ${humidity}%
💨  Wind: ${wind_speed} km/h ${wind_card}"
else
    data="N/A"
    tooltip="Weather in ${city} - N/A"
fi

printf '{"text":"%s","tooltip":"%s"}\n' "$data" "$tooltip"