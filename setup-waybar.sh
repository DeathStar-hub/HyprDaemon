#!/bin/bash
# ~/AI/setup-waybar.sh
# Turnkey setup for all waybar customizations

set -e

echo "🚀 Setting up Waybar customizations..."

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if AI config exists
if [[ ! -d ~/AI/config/waybar ]]; then
    echo -e "${YELLOW}Error: ~/AI/config/waybar not found!${NC}"
    echo "Please ensure the AI config directory exists."
    exit 1
fi

# Backup existing config
if [[ -d ~/.config/waybar ]]; then
    echo "📦 Backing up existing waybar config..."
    BACKUP_DIR=~/.config/waybar.backup.$(date +%Y%m%d_%H%M%S)
    cp -r ~/.config/waybar "$BACKUP_DIR"
    echo -e "${GREEN}✓ Backup created: $BACKUP_DIR${NC}"
fi

# Copy waybar config
echo "📁 Copying waybar configuration..."
cp -r ~/AI/config/waybar/* ~/.config/waybar/
echo -e "${GREEN}✓ Configuration copied${NC}"

# Make scripts executable
echo "🔧 Setting script permissions..."
chmod +x ~/.config/waybar/scripts/*.sh
echo -e "${GREEN}✓ Scripts made executable${NC}"

# Test scripts
echo "🧪 Testing scripts..."

# Test CPU spark
if ~/.config/waybar/scripts/cpu-spark.sh >/dev/null 2>&1; then
    echo -e "${GREEN}✓ CPU sparkline working${NC}"
else
    echo -e "${YELLOW}⚠ CPU sparkline test failed${NC}"
fi

# Test GPU spark
if ~/.config/waybar/scripts/gpu-spark.sh >/dev/null 2>&1; then
    echo -e "${GREEN}✓ GPU sparkline working${NC}"
else
    echo -e "${YELLOW}⚠ GPU sparkline test failed${NC}"
fi

# Test weather
if ~/.config/waybar/scripts/weather.sh >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Weather widget working${NC}"
else
    echo -e "${YELLOW}⚠ Weather widget test failed${NC}"
fi

# Test battery
if ~/.config/waybar/scripts/custom-battery.sh >/dev/null 2>&1; then
    echo -e "${GREEN}✓ Battery widget working${NC}"
else
    echo -e "${YELLOW}⚠ Battery widget test failed${NC}"
fi

# Restart waybar
echo "🔄 Restarting waybar..."
pkill waybar 2>/dev/null || true
sleep 1
waybar &>/dev/null &
echo -e "${GREEN}✓ Waybar restarted${NC}"

echo ""
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Waybar setup complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}"
echo ""
echo "📊 Modules installed:"
echo "  • CPU sparkline (usage + frequency)"
echo "  • GPU sparkline (load + frequency)"
echo "  • Weather widget (with radar menu)"
echo "  • Battery widget (with idle control)"
echo ""
echo "📚 Documentation: ~/AI/waybar-complete-guide.md"
echo "🔧 Troubleshooting: ~/AI/projects/hypr/waybar-troubleshooting.md"
echo ""
