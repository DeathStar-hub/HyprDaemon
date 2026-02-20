#!/bin/bash
# ~/.config/waybar/scripts/weather-detailed.sh
# Detailed weather popup script

city="Whitecourt"
lat="54.15"
lon="-115.68"

echo "🌤️  Fetching detailed weather for $city..."
echo "═══════════════════════════════════════════════════════════════"

response=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m,winddirection_10m,weathercode,precipitation_probability&daily=weathercode,temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=auto&forecast_days=3")

if [ -n "$response" ]; then
    # Current weather
    current_temp=$(echo "$response" | jq -r '.current_weather.temperature')
    current_wind=$(echo "$response" | jq -r '.current_weather.windspeed')
    current_wind_dir=$(echo "$response" | jq -r '.current_weather.winddirection')
    current_code=$(echo "$response" | jq -r '.current_weather.weathercode')
    current_humidity=$(echo "$response" | jq -r '.hourly.relativehumidity_2m[0]')
    current_precip=$(echo "$response" | jq -r '.hourly.precipitation_probability[0]')
    
    # Convert wind direction to compass
    get_wind_dir() {
        local dir=$1
        if [ "$dir" -ge 337 ] || [ "$dir" -lt 23 ]; then echo "N"
        elif [ "$dir" -ge 23 ] && [ "$dir" -lt 68 ]; then echo "NE"
        elif [ "$dir" -ge 68 ] && [ "$dir" -lt 113 ]; then echo "E"
        elif [ "$dir" -ge 113 ] && [ "$dir" -lt 158 ]; then echo "SE"
        elif [ "$dir" -ge 158 ] && [ "$dir" -lt 203 ]; then echo "S"
        elif [ "$dir" -ge 203 ] && [ "$dir" -lt 248 ]; then echo "SW"
        elif [ "$dir" -ge 248 ] && [ "$dir" -lt 293 ]; then echo "W"
        elif [ "$dir" -ge 293 ] && [ "$dir" -lt 337 ]; then echo "NW"
        fi
    }
    
    wind_dir=$(get_wind_dir "$current_wind_dir")
    
    # Weather descriptions
    get_weather_desc() {
        case $1 in
            0) echo "Clear sky" ;;
            1) echo "Mainly clear" ;;
            2) echo "Partly cloudy" ;;
            3) echo "Overcast" ;;
            45) echo "Fog" ;;
            48) echo "Depositing rime fog" ;;
            51|53|55) echo "Drizzle" ;;
            56|57) echo "Freezing drizzle" ;;
            61|63|65) echo "Rain" ;;
            66|67) echo "Freezing rain" ;;
            71|73|75) echo "Snow" ;;
            77) echo "Snow grains" ;;
            80|81|82) echo "Rain showers" ;;
            85|86) echo "Snow showers" ;;
            95|96|99) echo "Thunderstorm" ;;
            *) echo "Unknown" ;;
        esac
    }
    
    weather_desc=$(get_weather_desc "$current_code")
    
    echo "📍 CURRENT CONDITIONS"
    echo "   Temperature: ${current_temp}°C"
    echo "   Conditions: $weather_desc"
    echo "   Humidity: ${current_humidity}%"
    echo "   Wind: ${current_wind} km/h $wind_dir"
    echo "   Precip chance: ${current_precip}%"
    echo ""
    
    # Today's forecast
    today_max=$(echo "$response" | jq -r '.daily.temperature_2m_max[0]')
    today_min=$(echo "$response" | jq -r '.daily.temperature_2m_min[0]')
    today_precip=$(echo "$response" | jq -r '.daily.precipitation_sum[0]')
    today_code=$(echo "$response" | jq -r '.daily.weathercode[0]')
    today_desc=$(get_weather_desc "$today_code")
    
    echo "📅 TODAY'S FORECAST"
    echo "   High: ${today_max}°C  |  Low: ${today_min}°C"
    echo "   Conditions: $today_desc"
    echo "   Precipitation: ${today_precip} mm"
    echo ""
    
    # Tomorrow's forecast
    tomorrow_max=$(echo "$response" | jq -r '.daily.temperature_2m_max[1]')
    tomorrow_min=$(echo "$response" | jq -r '.daily.temperature_2m_min[1]')
    tomorrow_precip=$(echo "$response" | jq -r '.daily.precipitation_sum[1]')
    tomorrow_code=$(echo "$response" | jq -r '.daily.weathercode[1]')
    tomorrow_desc=$(get_weather_desc "$tomorrow_code")
    
    echo "📅 TOMORROW"
    echo "   High: ${tomorrow_max}°C  |  Low: ${tomorrow_min}°C"
    echo "   Conditions: $tomorrow_desc"
    echo "   Precipitation: ${tomorrow_precip} mm"
    echo ""
    
    # Day after tomorrow
    day3_max=$(echo "$response" | jq -r '.daily.temperature_2m_max[2]')
    day3_min=$(echo "$response" | jq -r '.daily.temperature_2m_min[2]')
    day3_precip=$(echo "$response" | jq -r '.daily.precipitation_sum[2]')
    day3_code=$(echo "$response" | jq -r '.daily.weathercode[2]')
    day3_desc=$(get_weather_desc "$day3_code")
    
    echo "📅 $(date -d '+2 days' '+%A')"
    echo "   High: ${day3_max}°C  |  Low: ${day3_min}°C"
    echo "   Conditions: $day3_desc"
    echo "   Precipitation: ${day3_precip} mm"
    echo ""
    
    echo "🌐 Online: https://windy.com/?latitude=$lat&longitude=$lon"
    echo ""
    echo "═══════════════════════════════════════════════════════════════"
    echo "Press any key to close..."
    read -n 1
    
else
    echo "❌ Failed to fetch weather data"
    echo "Please check your internet connection"
    echo ""
    echo "Press any key to close..."
    read -n 1
fi