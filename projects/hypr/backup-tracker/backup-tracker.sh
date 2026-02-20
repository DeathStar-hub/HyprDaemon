#!/bin/bash
# Session-based Backup Tracker
# Tracks sessions since last backup, prompts at threshold

SESSION_FILE="$HOME/.config/backups/.session-count"
LAST_BACKUP_FILE="$HOME/.config/backups/.last-backup-date"
BACKUP_THRESHOLD=5  # Prompt after this many sessions

# Read current session count
get_session_count() {
    if [ -f "$SESSION_FILE" ]; then
        cat "$SESSION_FILE"
    else
        echo "0"
    fi
}

# Get last backup date
get_last_backup_date() {
    if [ -f "$LAST_BACKUP_FILE" ]; then
        cat "$LAST_BACKUP_FILE"
    else
        echo "Never"
    fi
}

# Record a new session
record_session() {
    mkdir -p "$HOME/.config/backups"
    count=$(get_session_count)
    new_count=$((count + 1))
    echo "$new_count" > "$SESSION_FILE"
    echo "$new_count"
}

# Mark backup as done
mark_backup_done() {
    echo "$(date +'%Y-%m-%d %H:%M')" > "$LAST_BACKUP_FILE"
    echo "0" > "$SESSION_FILE"
}

# Check if backup needed
needs_backup() {
    count=$(get_session_count)
    if [ "$count" -ge "$BACKUP_THRESHOLD" ]; then
        return 0  # true
    fi
    return 1  # false
}

# Get status message for startup
get_status_message() {
    count=$(get_session_count)
    last_date=$(get_last_backup_date)
    
    if [ "$count" -eq "0" ]; then
        echo "✅ Configs backed up ($last_date)"
    elif [ "$count" -lt "$BACKUP_THRESHOLD" ]; then
        echo "📊 $count session(s) since backup (last: $last_date)"
    else
        echo "⚠️  $count sessions since backup - BACKUP RECOMMENDED"
    fi
}

# Run as startup check
case "$1" in
    --record)
        record_session
        ;;
    --status)
        get_status_message
        ;;
    --mark-done)
        mark_backup_done
        ;;
    --needs-backup)
        needs_backup
        ;;
    --count)
        get_session_count
        ;;
    --reset)
        echo "0" > "$SESSION_FILE"
        echo "Never" > "$LAST_BACKUP_FILE"
        ;;
    *)
        echo "Usage: $0 {--record|--status|--mark-done|--needs-backup|--reset}"
        ;;
esac
