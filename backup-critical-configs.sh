#!/bin/bash
# Critical Config Backup Script
# Run this before editing any critical configuration files

BACKUP_DIR="$HOME/.config/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Function to backup a file
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        local filename=$(basename "$file")
        local backup_name="${BACKUP_DIR}/${filename}.backup-${TIMESTAMP}"
        cp "$file" "$backup_name"
        echo "✅ Backed up: $file → $backup_name"
    else
        echo "⚠️  File not found: $file"
    fi
}

echo "=========================================="
echo "🛡️  CRITICAL CONFIG BACKUP"
echo "=========================================="
echo "Timestamp: $TIMESTAMP"
echo ""

# Backup critical configs
backup_file "$HOME/.config/opencode/opencode.json"
backup_file "$HOME/.config/hypr/hyprland.conf"
backup_file "$HOME/.config/hypr/bindings.conf"
backup_file "$HOME/.config/waybar/config.jsonc"
backup_file "$HOME/.config/waybar/style.css"

echo ""
echo "=========================================="
echo "📊 Backup complete!"
echo "Location: $BACKUP_DIR"
echo "=========================================="
