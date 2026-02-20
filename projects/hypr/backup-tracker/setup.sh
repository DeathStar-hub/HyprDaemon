#!/bin/bash
# Session-Based Backup Tracker Setup
# Run this to install the backup tracker on a new system

echo "=== Installing Backup Tracker ==="

# Create backup directory
mkdir -p ~/.config/backups

# Copy scripts
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cp "$SCRIPT_DIR/backup-tracker.sh" ~/.config/backups/
cp "$SCRIPT_DIR/backup-now.sh" ~/.config/backups/
cp "$SCRIPT_DIR/waybar-backup-status.sh" ~/.config/backups/

chmod +x ~/.config/backups/*.sh

# Add to autostart (hyprland)
if ! grep -q "backup-tracker.sh" ~/.config/hypr/autostart.conf 2>/dev/null; then
    echo "" >> ~/.config/hypr/autostart.conf
    echo "# Session backup tracker" >> ~/.config/hypr/autostart.conf
    echo "exec-once = ~/.config/backups/backup-tracker.sh --record" >> ~/.config/hypr/autostart.conf
    echo "exec-once = sleep 3 && notify-send -u normal \"🔄 Session Backup Status\" \"\$($HOME/.config/backups/backup-tracker.sh --status)\"" >> ~/.config/hypr/autostart.conf
    echo "Added to autostart.conf"
fi

# Add to waybar config
if ! grep -q "custom/backup-status" ~/.config/waybar/config.jsonc 2>/dev/null; then
    echo ""
    echo "=== WAYBAR CONFIG NEEDS MANUAL UPDATE ==="
    echo "Add to modules-center:"
    echo '  "custom/backup-status",'
    echo ""
    echo "Add to end of config (before final }):"
    echo '  "custom/backup-status": {'
    echo '    "exec": "~/.config/backups/waybar-backup-status.sh",'
    echo '    "return-type": "json",'
    echo '    "format": "{}",'
    echo '    "interval": 300,'
    echo '    "on-click": "~/.config/backups/backup-now.sh",'
    echo '    "tooltip": true'
    echo '  },'
fi

# Modify cleanup-sessions.sh to track sessions
if ! grep -q "backup-tracker.sh" ~/AI/cleanup-sessions.sh 2>/dev/null; then
    echo ""
    echo "=== CLEANUP-SESSIONS.SH NEEDS MANUAL UPDATE ==="
    echo "Add after 'mv session*.md' section:"
    echo 'if [ -f "$HOME/.config/backups/backup-tracker.sh" ]; then'
    echo '    "$HOME/.config/backups/backup-tracker.sh" --record'
    echo 'fi'
fi

echo ""
echo "=== Setup Complete ==="
