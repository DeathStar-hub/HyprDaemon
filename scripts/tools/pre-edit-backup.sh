#!/bin/bash
# ~/AI/pre-edit-backup.sh
# Helper script for AI to create backups before editing config files
# Usage: ~/AI/pre-edit-backup.sh /path/to/file

set -e

FILE="$1"

if [[ -z "$FILE" ]]; then
    echo "❌ Usage: $0 <file-path>"
    echo "Example: $0 ~/.config/waybar/config.jsonc"
    exit 1
fi

# Check if file exists
if [[ ! -f "$FILE" ]]; then
    echo "❌ Error: File not found: $FILE"
    exit 1
fi

# Check if file is in editable directory (not .local)
if [[ "$FILE" == */.local/* ]]; then
    echo "🚨 WARNING: You're about to edit a file in ~/.local/"
    echo "   Files in ~/.local/ are package-managed and will be overwritten on updates!"
    echo "   Consider editing the user customization in ~/.config/ instead"
    echo ""
    read -p "Continue anyway? (y/N): " confirm
    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "❌ Aborted by user"
        exit 1
    fi
fi

# Create timestamped backup
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="${FILE}.backup-${TIMESTAMP}"

echo "🔄 Creating backup..."
cp "$FILE" "$BACKUP_FILE"
echo "✅ Backup created: $BACKUP_FILE"

# Extract important values to note
echo ""
echo "📋 Important values to note before editing:"
echo "------------------------------------------"

# Check for fonts
if grep -q "font" "$FILE" 2>/dev/null; then
    echo "Fonts found:"
    grep -i "font" "$FILE" | head -5
fi

# Check for colors (hex codes)
if grep -qE "#[0-9A-Fa-f]{6}" "$FILE" 2>/dev/null; then
    echo "Color codes found:"
    grep -oE "#[0-9A-Fa-f]{6}" "$FILE" | sort -u | head -5
fi

# Check for numeric values (heights, widths, sizes)
if grep -qE "height|width|size|timeout" "$FILE" 2>/dev/null; then
    echo "Numeric settings found:"
    grep -iE "(height|width|size|timeout)\s*[:=]" "$FILE" | head -5
fi

# Check for paths
if grep -qE "(home/|/usr/|\.config)" "$FILE" 2>/dev/null; then
    echo "Paths found:"
    grep -oE "(/home/[^\"'\s]+|/usr/[^\"'\s]+|\.config/[^\"'\s]+)" "$FILE" | head -5
fi

echo "------------------------------------------"
echo ""
echo "💡 Keep these values in mind when editing"
echo ""
echo "🚀 Ready to edit: $FILE"
