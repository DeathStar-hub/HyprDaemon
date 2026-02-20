#!/bin/bash
# Fix hardcoded username paths for multi-system portability
# Replaces /home/nemesis and /home/tokka with $HOME or ~

set -e

echo "🔧 Fixing Hardcoded Username Paths..."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

FIXED_COUNT=0
SKIPPED_COUNT=0

# Function to fix file
fix_file() {
    local file=$1
    local temp_file=$(mktemp)

    # Skip if file doesn't exist
    [[ ! -f "$file" ]] && return

    # Check if file has hardcoded paths
    if ! grep -q "/home/nemesis\|/home/tokka" "$file" 2>/dev/null; then
        ((SKIPPED_COUNT++))
        return
    fi

    # Make replacements
    sed -e 's|/home/nemesis/|~/.config/|g' \
        -e 's|/home/nemesis|~|g' \
        -e 's|/home/tokka/|$HOME/|g' \
        -e 's|/home/tokka|$HOME|g' \
        "$file" > "$temp_file"

    # Check if changes were made
    if ! cmp -s "$file" "$temp_file"; then
        echo -e "${GREEN}✓${NC} Fixed: $file"
        mv "$temp_file" "$file"
        ((FIXED_COUNT++))
    else
        ((SKIPPED_COUNT++))
        rm "$temp_file"
    fi
}

# Files to fix
FILES=(
    ~/.config/hypr/bindings.conf
    ~/.config/hypr/autostart.conf
    ~/.config/waybar/config.jsonc
    ~/.config/waybar/scripts/custom-battery.sh
    ~/.config/waybar/scripts/idle-menu.sh
    ~/.config/waybar/scripts/sleep-interrupt-menu.sh
    ~/.config/waybar/scripts/idle-controller.sh
    ~/.config/waybar/scripts/waybar-toggle.sh
    ~/.config/waybar/scripts/cpu-spark.sh
    ~/.config/waybar/scripts/weather.sh
    ~/.config/kitty/kitty.conf
    ~/.config/walker/config.toml
)

echo "📝 Processing config files..."
echo ""

for file in "${FILES[@]}"; do
    fix_file "$file"
done

echo ""
echo "📊 Summary:"
echo "  - Fixed: $FIXED_COUNT files"
echo "  - Skipped: $SKIPPED_COUNT files"
echo ""

# Verify no hardcoded paths remain (excluding backups)
echo "🔍 Checking for remaining hardcoded paths..."
REMAINING=$(grep -r "/home/nemesis\|/home/tokka" ~/.config/hypr ~/.config/waybar ~/.config/walker ~/.config/kitty 2>/dev/null \
    | grep -v "\.backup\|\.log\|\.bak" | wc -l)

if [ "$REMAINING" -eq 0 ]; then
    echo -e "${GREEN}✓ No hardcoded paths found!${NC}"
else
    echo -e "${YELLOW}⚠ $REMAINING hardcoded paths still exist${NC}"
    echo ""
    echo "Remaining hardcoded paths:"
    grep -r "/home/nemesis\|/home/tokka" ~/.config/hypr ~/.config/waybar ~/.config/walker ~/.config/kitty 2>/dev/null \
        | grep -v "\.backup\|\.log\|\.bak" || true
fi

echo ""
echo -e "${GREEN}✅ Done!${NC}"
echo ""
echo "🔄 To apply changes:"
echo "   hyprctl reload"
echo "   pkill waybar && waybar"
echo ""
