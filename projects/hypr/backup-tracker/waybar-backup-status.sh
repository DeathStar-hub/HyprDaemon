#!/bin/bash
# Waybar module for backup status

TRACKER="$HOME/.config/backups/backup-tracker.sh"

count=$($TRACKER --count 2>/dev/null)

if [ -z "$count" ]; then
    count=0
fi

# Get full status message
status=$($TRACKER --status)

if [ "$count" -ge 5 ]; then
    # Critical - needs backup
    echo "{\"text\": \"⚠️  $count\", \"tooltip\": \"$status\nClick to backup now\"}"
elif [ "$count" -ge 1 ]; then
    # Normal - show count
    echo "{\"text\": \"💾 $count\", \"tooltip\": \"$status\nClick to backup now\"}"
else
    # Up to date
    echo "{\"text\": \"✅\", \"tooltip\": \"$status\"}"
fi
