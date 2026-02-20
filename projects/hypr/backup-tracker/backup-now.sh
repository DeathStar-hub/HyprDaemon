#!/bin/bash
# Quick backup with session reset
# Usage: backup-now (or bind to a key)

SCRIPT_DIR="$HOME/AI.Bacl/backups"
TRACKER="$HOME/.config/backups/backup-tracker.sh"

echo "🔄 Running config backup..."

# Run the backup
$SCRIPT_DIR/backup-configs.sh

# Reset the session counter
$TRACKER --mark-done

echo "✅ Backup complete! Session counter reset."
notify-send -u normal "💾 Backup Complete" "Configs saved, session counter reset"
