#!/usr/bin/env bash
# Idle Controller - Improved with proper process management

STATE_FILE="/tmp/idle_pause_state_$USER"
TIMER_FILE="/tmp/idle_pause_until_$USER"
TIMER_PID_FILE="/tmp/idle_pause_timer_pid_$USER"

notify() {
  DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus" \
  notify-send "Idle Control" "$1" 2>/dev/null || echo "$1"
}

# Ensure only one hypridle instance running
cleanup_hypridle() {
    pkill -9 hypridle 2>/dev/null || true
    sleep 0.1
}

pause_for() {
    local seconds="$1"
    local until=$(( $(date +%s) + seconds ))

    cleanup_hypridle

    echo "$until" > "$TIMER_FILE"
    echo "paused" > "$STATE_FILE"

    notify "Idle paused for $((seconds/60)) minutes"

    # Kill any existing timer
    if [[ -f "$TIMER_PID_FILE" ]]; then
        kill "$(cat "$TIMER_PID_FILE")" 2>/dev/null || true
    fi

    # Run timer in background and save PID
    (
        sleep "$seconds"
        [[ -f "$TIMER_PID_FILE" ]] && rm -f "$TIMER_PID_FILE"
        systemctl --user start hypridle
        rm -f "$STATE_FILE" "$TIMER_FILE"
        notify "Idle resumed"
    ) &
    echo $! > "$TIMER_PID_FILE"
}

pause_indefinite() {
    cleanup_hypridle
    echo "paused" > "$STATE_FILE"
    notify "Idle paused indefinitely"
}

resume_idle() {
    cleanup_hypridle

    if [[ -f "$TIMER_PID_FILE" ]]; then
        kill "$(cat "$TIMER_PID_FILE")" 2>/dev/null || true
        rm -f "$TIMER_PID_FILE"
    fi

    rm -f "$STATE_FILE" "$TIMER_FILE"
    systemctl --user start hypridle
    notify "Idle resumed"
}

case "$1" in
    pause-5)   pause_for 300 ;;
    pause-10)  pause_for 600 ;;
    pause-30)  pause_for 1800 ;;
    pause-60)  pause_for 3600 ;;
    pause-inf) pause_indefinite ;;
    resume)    resume_idle ;;
    status)
        if [[ -f "$STATE_FILE" ]]; then
            if [[ -f "$TIMER_FILE" ]]; then
                until=$(cat "$TIMER_FILE")
                now=$(date +%s)
                remaining=$((until - now))
                if [[ $remaining -gt 0 ]]; then
                    min=$((remaining / 60))
                    sec=$((remaining % 60))
                    echo "⏸️ ${min}m ${sec}s"
                else
                    echo "⏸️"
                fi
            else
                echo "⏸️"
            fi
        else
            echo ""
        fi
        ;;
esac