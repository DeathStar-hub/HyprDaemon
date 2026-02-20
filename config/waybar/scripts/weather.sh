# ~/.config/waybar/scripts/weather.sh
#!/usr/bin/env bash
# Requires: curl, jq, kitty (for terminal popup)
# Using Open-Meteo API (free, no API key required)
city="Whitecourt"
# Coordinates for Whitecourt, AB
lat="54.15"
lon="-115.68"

# Handle click events
if [ "$1" = "left" ]; then
    # Left click - show detailed weather in terminal popup
    kitty --class weather_popup --title "Weather Details" ~/.config/waybar/scripts/weather-detailed.sh
    exit 0
fi

if [ "$1" = "middle" ]; then
    # Middle click - open MSN weather forecast for Whitecourt, AB
    xdg-open "https://www.msn.com/en-ca/weather/forecast/in-Whitecourt,AB?loc=eyJsIjoiV2hpdGVjb3VydCIsInIiOiJBQiIsInIyIjoiRGl2aXNpb24gMTMiLCJjIjoiQ2FuYWRhIiwiaSI6IkNBIiwiZyI6ImVuLWNhIiwieCI6Ii0xMTUuNjg1NDkzNDY5MjM4MjgiLCJ5IjoiNTQuMTUwMTUwMjk5MDcyMjY2In0%3D&weadegreetype=C"
    exit 0
fi

if [ "$1" = "right" ]; then
    # Right click - radar menu in terminal
    kitty --title radar-menu ~/.config/waybar/scripts/radar-menu.sh
    if [ -f /tmp/weather_choice ]; then
        while IFS= read -r url; do
            xdg-open "$url" &
            sleep 0.5
        done < /tmp/weather_choice
        rm /tmp/weather_choice
    fi
    exit 0
fi

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

response=$(curl -m 10 -s "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m,winddirection_10m&timezone=auto")

if [ -n "$response" ]; then
    temp=$(echo "$response" | jq -r '.current_weather.temperature')
    code=$(echo "$response" | jq -r '.current_weather.weathercode')
    icon=$(get_weather_icon "$code")
    data="${icon} ${temp}°C"
    
    # Enhanced tooltip with more details
    wind_speed=$(echo "$response" | jq -r '.current_weather.windspeed // "N/A"')
    wind_dir=$(echo "$response" | jq -r '.current_weather.winddirection // "N/A"')
    humidity=$(echo "$response" | jq -r '.hourly.relativehumidity_2m[0] // "N/A"')
    
    # Convert wind direction to compass
    wind_direction() {
        local dir=$1
        if [ "$dir" = "N/A" ]; then echo "N/A"
        elif [ "$dir" -ge 337 ] || [ "$dir" -lt 23 ]; then echo "N"
        elif [ "$dir" -ge 23 ] && [ "$dir" -lt 68 ]; then echo "NE"
        elif [ "$dir" -ge 68 ] && [ "$dir" -lt 113 ]; then echo "E"
        elif [ "$dir" -ge 113 ] && [ "$dir" -lt 158 ]; then echo "SE"
        elif [ "$dir" -ge 158 ] && [ "$dir" -lt 203 ]; then echo "S"
        elif [ "$dir" -ge 203 ] && [ "$dir" -lt 248 ]; then echo "SW"
        elif [ "$dir" -ge 248 ] && [ "$dir" -lt 293 ]; then echo "W"
        elif [ "$dir" -ge 293 ] && [ "$dir" -lt 337 ]; then echo "NW"
        fi
    }
    
    wind_compass=$(wind_direction $wind_dir)
    
    # Weather description
    weather_description() {
        local code=$1
        case $code in
            0) echo "Clear sky" ;;
            1) echo "Mainly clear" ;;
            2) echo "Partly cloudy" ;;
            3) echo "Overcast" ;;
            45) echo "Fog" ;;
            48) echo "Depositing rime fog" ;;
            51) echo "Light drizzle" ;;
            52) echo "Moderate drizzle" ;;
            53) echo "Dense drizzle" ;;
            54) echo "Light freezing drizzle" ;;
            55) echo "Dense freezing drizzle" ;;
            56) echo "Light freezing drizzle" ;;
            57) echo "Dense freezing drizzle" ;;
            61) echo "Slight rain" ;;
            62) echo "Moderate rain" ;;
            63) echo "Heavy rain" ;;
            64) echo "Light freezing rain" ;;
            65) echo "Heavy freezing rain" ;;
            66) echo "Light freezing rain" ;;
            67) echo "Heavy freezing rain" ;;
            71) echo "Slight snow" ;;
            72) echo "Moderate snow" ;;
            73) echo "Heavy snow" ;;
            74) echo "Slight snow" ;;
            75) echo "Heavy snow" ;;
            77) echo "Snow grains" ;;
            80) echo "Slight rain showers" ;;
            81) echo "Moderate rain showers" ;;
            82) echo "Violent rain showers" ;;
            85) echo "Slight snow showers" ;;
            86) echo "Heavy snow showers" ;;
            95) echo "Thunderstorm" ;;
            96) echo "Thunderstorm with slight hail" ;;
            99) echo "Thunderstorm with heavy hail" ;;
            *) echo "Unknown" ;;
        esac
    }
    
    condition=$(weather_description $code)
    tooltip="📍 $city: ${temp}°C\n💧 Humidity: ${humidity}%\n💨 Wind: ${wind_speed} km/h ${wind_compass}\n☁️ Condition: ${condition}"
else
    data="N/A"
    tooltip="Weather unavailable"
fi

printf '{"text":"%s","tooltip":"%s"}\n' "$data" "$tooltip"
