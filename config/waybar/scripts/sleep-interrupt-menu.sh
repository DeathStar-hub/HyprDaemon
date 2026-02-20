#!/bin/bash
# Sleep Interrupt Menu - Improved Version
# No fragile /tmp file communication - actions execute directly

TIMER_FILE="/tmp/idle_pause_until_$USER"

# Get current state
get_state() {
    if [[ -f "$TIMER_FILE" ]]; then
        until=$(cat "$TIMER_FILE")
        now=$(date +%s)
        remaining=$((until - now))
        if [[ $remaining -gt 0 ]]; then
            echo "timed:$remaining"
        else
            echo "active"
        fi
    else
        STATE_FILE="/tmp/idle_pause_state_$USER"
        if [[ -f "$STATE_FILE" ]]; then
            echo "indefinite"
        else
            echo "active"
        fi
    fi
}

STATE=$(get_state)

# Build menu based on state
if [[ "$STATE" == "active" ]]; then
    MENU="⏸️  5 minutes\n⏸️  10 minutes\n⏸️  30 minutes\n⏸️  1 hour\n⏸️  Indefinitely\n❌ Cancel"
else
    if [[ "$STATE" == "timed:"* ]]; then
        remaining=${STATE#timed:}
        min=$((remaining / 60))
        sec=$((remaining % 60))
        MENU="▶️  Resume (${min}m ${sec}s left)\n❌ Cancel"
    else
        MENU="▶️  Resume (indefinite)\n❌ Cancel"
    fi
fi

# Show menu with nice styling
kitty --class sleep-interrupt --name sleep-interrupt \
    --title sleep-interrupt \
    -o font_size=11 \
    -o initial_window_width=310 \
    -o initial_window_height=245 \
    -o remember_window_size=no \
    bash -c "
        SELECTION=\$(echo -e \"$MENU\" | fzf \
            --ansi \
            --prompt='💤  ' \
            --height=20 \
            --border=double \
            --border-label=' Sleep Control ' \
            --border-label-pos=top \
            --info=hidden \
            --no-separator \
            --color=bg:#1e1e2e,fg:#cdd6f4,bg+:#313244,fg+:#cdd6f4,hl:#f38ba8,hl+:#f38ba8,pointer:#f38ba8,marker:#b4befe,border:#cba6f7 \
            --color=header:#89b4fa,prompt:#cba6f7 \
            --reverse)
        echo \"\$SELECTION\" > /tmp/sleep_selection
        "

# Wait for kitty to finish
sleep 0.2

# Read selection
if [[ -f /tmp/sleep_selection ]]; then
    SELECTION=$(cat /tmp/sleep_selection)
    rm -f /tmp/sleep_selection
else
    exit 0
fi

[[ -z "$SELECTION" ]] && exit 0

# Execute action directly (no /tmp file)
case "$SELECTION" in
    *5\ minutes*)
        ~/.config/waybar/scripts/idle-controller.sh pause-5
        ;;
    *10\ minutes*)
        ~/.config/waybar/scripts/idle-controller.sh pause-10
        ;;
    *30\ minutes*)
        ~/.config/waybar/scripts/idle-controller.sh pause-30
        ;;
    *1\ hour*)
        ~/.config/waybar/scripts/idle-controller.sh pause-60
        ;;
    *Indefinitely*)
        ~/.config/waybar/scripts/idle-controller.sh pause-inf
        ;;
    *Resume*)
        ~/.config/waybar/scripts/idle-controller.sh resume
        ;;
    *Cancel*)
        exit 0
        ;;
esac