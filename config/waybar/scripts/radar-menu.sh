#!/bin/bash
# Weather Radar Menu Script

# Use kitty with specific floating window settings
kitty --class weather-radar --name weather-radar \
    --title radar-menu \
    -o font_size=11 \
    -o initial_window_width=600 \
    -o initial_window_height=400 \
    -o remember_window_size=no \
    -o enabled_layouts=stack \
    bash -c '
        echo -e "          \e[1;36m╔══════════════════════════════════════╗\e[0m"
        echo -e "          \e[1;36m║         🌦️  Weather Radar Menu        ║\e[0m"
        echo -e "          \e[1;36m╠══════════════════════════════════════╣\e[0m"
        echo -e "          \e[1;31m║ 1. 🌧️ RainViewer - Global radar        ║\e[0m"
        echo -e "          \e[1;32m║ 2. 🌪️ Windy - Interactive weather map   ║\e[0m"
        echo -e "          \e[1;33m║ 3. 📡 AccuWeather - Local radar         ║\e[0m"
        echo -e "          \e[1;34m║ 4. 🌤️ MSN Weather - Whitecourt forecast ║\e[0m"
        echo -e "          \e[1;35m║ 5. 📰 CTV News - Edmonton weather       ║\e[0m"
        echo -e "          \e[1;36m║ 6. 📰 Global News - Edmonton weather    ║\e[0m"
        echo -e "          \e[1;37m║ 7. 🛰️ Environment Canada - Satellite    ║\e[0m"
        echo -e "          \e[1;36m╠══════════════════════════════════════╣\e[0m"
        echo -e "          \e[1;31m║ 8. 🚀 Open all weather sources           ║\e[0m"
        echo -e "          \e[1;36m╚══════════════════════════════════════╝\e[0m"
        echo ""
        read -p "Enter choice (1-8): " choice
        echo "Choice entered: '$choice'"
        case $choice in
            1) echo "Opening RainViewer..."; echo "https://www.rainviewer.com/weather-radar-map-live.html?lat=54.15&lon=-115.68&zoom=8" > /tmp/weather_choice; sleep 1 ;;
            2) echo "Opening Windy..."; echo "https://www.windy.com/?53.862,-116.899,8" > /tmp/weather_choice; sleep 1 ;;
            3) echo "Opening AccuWeather..."; echo "https://www.accuweather.com/en/ca/whitecourt/t7s/weather-radar/51942" > /tmp/weather_choice; sleep 1 ;;
            4) echo "Opening MSN Weather..."; echo "https://www.msn.com/en-ca/weather/forecast/in-Whitecourt,AB?loc=eyJsIjoiV2hpdGVjb3VydCIsInIiOiJBQiIsInIyIjoiRGl2aXNpb24gMTMiLCJjIjoiQ2FuYWRhIiwiaSI6IkNBIiwiZyI6ImVuLWNhIiwieCI6Ii0xMTUuNjg1NDkzNDY5MjM4MjgiLCJ5IjoiNTQuMTUwMTUwMjk5MDcyMjY2In0%3D&weadegreetype=C" > /tmp/weather_choice; sleep 1 ;;
            5) echo "Opening CTV News..."; echo "https://www.ctvnews.ca/edmonton/weather/" > /tmp/weather_choice; sleep 1 ;;
            6) echo "Opening Global News..."; echo "https://globalnews.ca/edmonton/weather/CAXX0126" > /tmp/weather_choice; sleep 1 ;;
            7) echo "Opening Environment Canada..."; echo "https://weather.gc.ca/satellite/satellite_anim_e.html?sat=goes&area=wcan&type=1070" > /tmp/weather_choice; sleep 1 ;;
            8)
                echo "Opening all weather sources..."
                cat > /tmp/weather_choice << 'EOF'
https://www.rainviewer.com/weather-radar-map-live.html?lat=54.15&lon=-115.68&zoom=8
https://www.windy.com/?53.862,-116.899,8
https://www.accuweather.com/en/ca/whitecourt/t7s/weather-radar/51942
https://www.msn.com/en-ca/weather/forecast/in-Whitecourt,AB?loc=eyJsIjoiV2hpdGVjb3VydCIsInIiOiJBQiIsInIyIjoiRGl2aXNpb24gMTMiLCJjIjoiQ2FuYWRhIiwiaSI6IkNBIiwiZyI6ImVuLWNhIiwieCI6Ii0xMTUuNjg1NDkzNDY5MjM4MjgiLCJ5IjoiNTQuMTUwMTUwMjk5MDcyMjY2In0%3D&weadegreetype=C
https://www.ctvnews.ca/edmonton/weather/
https://globalnews.ca/edmonton/weather/CAXX0126
https://weather.gc.ca/satellite/satellite_anim_e.html?sat=goes&area=wcan&type=1070
EOF
                sleep 1
                ;;
            *) echo "Invalid choice"; sleep 1 ;;
        esac
        exit 0
    '
case $choice in
    1) xdg-open 'https://www.rainviewer.com/weather-radar-map-live.html?lat=54.15&lon=-115.68&zoom=8' ;;
    2) xdg-open 'https://www.windy.com/?53.862,-116.899,8' ;;
    3) xdg-open 'https://www.accuweather.com/en/ca/whitecourt/t7s/weather-radar/51942' ;;
    4) xdg-open 'https://www.msn.com/en-ca/weather/forecast/in-Whitecourt,AB?loc=eyJsIjoiV2hpdGVjb3VydCIsInIiOiJBQiIsInIyIjoiRGl2aXNpb24gMTMiLCJjIjoiQ2FuYWRhIiwiaSI6IkNBIiwiZyI6ImVuLWNhIiwieCI6Ii0xMTUuNjg1NDkzNDY5MjM4MjgiLCJ5IjoiNTQuMTUwMTUwMjk5MDcyMjY2In0%3D&weadegreetype=C' ;;
    5) xdg-open 'https://www.ctvnews.ca/edmonton/weather/' ;;
    6) xdg-open 'https://globalnews.ca/edmonton/weather/CAXX0126' ;;
    7) xdg-open 'https://weather.gc.ca/satellite/satellite_anim_e.html?sat=goes&area=wcan&type=1070' ;;
    8)
        echo 'Opening all weather sources...'
        # Open all URLs in background simultaneously
        xdg-open 'https://www.rainviewer.com/weather-radar-map-live.html?lat=54.15&lon=-115.68&zoom=8' &
        xdg-open 'https://www.windy.com/?53.862,-116.899,8' &
        xdg-open 'https://www.accuweather.com/en/ca/whitecourt/t7s/weather-radar/51942' &
        xdg-open 'https://www.msn.com/en-ca/weather/forecast/in-Whitecourt,AB?loc=eyJsIjoiV2hpdGVjb3VydCIsInIiOiJBQiIsInIyIjoiRGl2aXNpb24gMTMiLCJjIjoiQ2FuYWRhIiwiaSI6IkNBIiwiZyI6ImVuLWNhIiwieCI6Ii0xMTUuNjg1NDkzNDY5MjM4MjgiLCJ5IjoiNTQuMTUwMTUwMjk5MDcyMjY2In0%3D&weadegreetype=C' &
        xdg-open 'https://www.ctvnews.ca/edmonton/weather/' &
        xdg-open 'https://globalnews.ca/edmonton/weather/CAXX0126' &
        xdg-open 'https://weather.gc.ca/satellite/satellite_anim_e.html?sat=goes&area=wcan&type=1070' &
        wait  # Wait for all background processes to complete
        echo 'All tabs opened!'
        ;;
    *) echo 'Invalid choice' ;;
esac