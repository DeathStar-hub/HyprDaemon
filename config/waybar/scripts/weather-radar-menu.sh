#!/usr/bin/env bash
# ~/.config/waybar/scripts/weather-radar-menu.sh
# Weather radar menu script

kitty --class weather-radar --title 'Weather Radar Menu' bash -c "
echo 'Weather Radar Sources:'
echo '1. RainViewer'
echo '2. Windy'
echo '3. AccuWeather'
echo '4. Environment Canada'
echo '5. Ventusky'
echo '6. Meteologix'
echo '7. The Weather Channel'
echo ''
echo -n 'Choose 1-7: '
read choice
case \$choice in
    1) xdg-open 'https://www.rainviewer.com/' ;;
    2) xdg-open 'https://www.windy.com/' ;;
    3) xdg-open 'https://www.accuweather.com/' ;;
    4) xdg-open 'https://weather.gc.ca/' ;;
    5) xdg-open 'https://www.ventusky.com/' ;;
    6) xdg-open 'https://www.meteologix.com/' ;;
    7) xdg-open 'https://weather.com/' ;;
    *) echo 'Invalid choice' ;;
esac
"