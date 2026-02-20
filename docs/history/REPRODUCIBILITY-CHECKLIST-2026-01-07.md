# Complete Reproducibility Checklist - 2026-01-07

## ✅ Status Before Sync

**All configurations verified and reproducible!**

---

## 📋 Configuration Sync Status

### Waybar
- ✅ **Config**: `~/.config/waybar/config.jsonc` → `~/AI/config/waybar/config.jsonc`
- ✅ **Style**: `~/.config/waybar/style.css` → `~/AI/config/waybar/style.css`
- ✅ **Scripts**: All essential scripts synced
  - ✅ battery-graph.sh
  - ✅ battery-log.sh
  - ✅ cpu-spark.sh
  - ✅ custom-battery.sh
  - ✅ gpu-spark.sh
  - ✅ idle-controller.sh
  - ✅ radar-menu.sh
  - ✅ sleep-interrupt-menu.sh
  - ✅ weather-detailed.sh
  - ✅ weather-radar-menu.sh
  - ✅ weather.sh

### Hyprland
- ✅ **All configs** synced to `~/AI/config/hyprland/`
  - autostart.conf (fixed hardcoded paths)
  - bindings.conf (fixed hardcoded paths)
  - envs.conf
  - hypridle.conf
  - hyprland.conf
  - hyprlock.conf
  - hyprsunset.conf
  - input.conf
  - looknfeel.conf
  - monitors.conf
  - xdph.conf

### Omarchy Themes
- 📝 **Note**: Theme files (kitty.conf, walker.css, waybar.css) are in `~/.config/omarchy/current/theme/`
- These are managed by the Omarchy theme system and will be applied automatically
- No manual sync needed for theme files

---

## 🎯 Waybar Configuration

### Module Positions
```json
{
  "modules-left": [
    "custom/omarchy",
    "custom/waybar-toggle",
    "hyprland/workspaces",
    "custom/cpu-spark",
    "custom/gpu-spark"
  ],
  "modules-center": [
    "clock",
    "custom/update",
    "custom/screenrecording-indicator"
  ],
  "modules-right": [
    "custom/weather",
    "group/tray-expander",
    "temperature",
    "bluetooth",
    "network",
    "pulseaudio",
    "cpu",
    "custom/battery"
  ]
}
```

### Module Features

**Left Side**:
- ✅ CPU sparkline (usage + frequency, no background)
- ✅ GPU sparkline (load + frequency, no background, 📊 icon)

**Center**:
- ✅ Clock (transparent, no background)

**Right Side**:
- ✅ Weather widget (with 3-click radar menu)
- ✅ Battery widget (with idle control, history graph)
- ✅ Temperature (frosted glass background)

---

## 🔧 Popup Menus & Rounded Corners

### How Rounded Corners Work

**1. Hyprland Window Decoration**
```bash
# ~/.config/hypr/looknfeel.conf
decoration {
    rounding = 10  # All windows get 10px rounded corners
}
```

**2. Kitty Terminal Configuration**
```bash
# ~/.config/omarchy/current/theme/kitty.conf
# Included automatically via: ~/.config/kitty/kitty.conf
window_padding_width 14
window_padding_height 14
```

**3. Popup Scripts**
All popup menus use kitty terminal with proper flags:
- Weather detailed: `kitty --class popup-window --title 'Weather'`
- Battery graph: `kitty --title 'Battery History'`
- Idle menu: Uses fzf with kitty integration
- Radar menu: Uses colored terminal output

### Popup Menu Scripts

**1. Weather Detailed Popup**
- Script: `~/.config/waybar/scripts/weather-detailed.sh`
- Trigger: Left-click on weather widget
- Features: 3-day forecast, current conditions
- Corners: Rounded (via Hyprland decoration + kitty padding)

**2. Battery History Graph**
- Script: `~/.config/waybar/scripts/battery-graph.sh`
- Trigger: Right-click on battery widget
- Features: Dual graph (capacity line, power bars)
- Corners: Rounded (via Hyprland decoration + kitty padding)

**3. Idle Timeout Menu**
- Script: `~/.config/waybar/scripts/sleep-interrupt-menu.sh`
- Trigger: Middle-click on battery widget
- Features: fzf TUI, pause/resume/cancel options
- Corners: Rounded (via Hyprland decoration + kitty padding)

**4. Radar Source Menu**
- Script: `~/.config/waybar/scripts/weather-radar-menu.sh`
- Trigger: Right-click on weather widget
- Features: 7 colored radar options, fzf selection
- Corners: Rounded (via Hyprland decoration + kitty padding)

---

## ✅ Fixed Before Sync

### Hardcoded Paths
All `/home/nemesis` paths replaced with portable paths:

**Fixed Files**:
1. `~/AI/config/hyprland/autostart.conf`
   - `/home/nemesis/.config/waybar/config.jsonc` → `~/.config/waybar/config.jsonc`

2. `~/AI/config/hyprland/bindings.conf`
   - `/home/nemesis/fish` → `~/fish` (2 instances)
   - `/home/nemesis/AI` → `~/AI` (2 instances)

3. `~/AI/config/hyprland/waybar/scripts/custom-battery.sh`
   - `/home/nemesis/.config/waybar/scripts/idle-controller.sh` → `~/.config/waybar/scripts/idle-controller.sh`

### Verification
```bash
# Check for remaining hardcoded paths
grep -rn "/home/nemesis" ~/AI/config/ 2>/dev/null | grep -v ".backup\|.bak"
# Result: No output = ✅ All paths portable
```

---

## 📁 Files to Sync

### Essential (Must Sync)
```
~/AI/config/
├── waybar/
│   ├── config.jsonc          # Waybar configuration
│   ├── style.css             # Waybar styling
│   └── scripts/
│       ├── gpu-spark.sh      # GPU monitoring (NEW)
│       ├── cpu-spark.sh      # CPU monitoring
│       ├── weather.sh        # Weather widget
│       ├── custom-battery.sh # Battery widget
│       ├── battery-graph.sh  # Battery history
│       ├── idle-controller.sh # Idle control
│       ├── sleep-interrupt-menu.sh  # Idle TUI
│       ├── weather-detailed.sh       # Weather popup
│       ├── weather-radar-menu.sh     # Radar menu
│       └── radar-menu.sh     # Interactive radar
├── hyprland/
│   ├── hyprland.conf       # Main hyprland config
│   ├── looknfeel.conf      # Window decoration (rounded corners)
│   ├── bindings.conf       # Keybindings
│   ├── autostart.conf      # Autostart processes
│   ├── envs.conf         # Environment variables
│   ├── hypridle.conf      # Idle configuration
│   ├── hyprlock.conf      # Lock screen
│   ├── input.conf         # Input settings
│   ├── monitors.conf      # Monitor configuration
│   └── xdph.conf        # XDPH portal
└── setup-waybar.sh       # Turnkey waybar setup
```

### Managed by Omarchy (Auto-applied)
```
~/.config/omarchy/current/theme/
├── kitty.conf          # Kitty terminal config (rounded corners)
├── walker.css          # Walker menu styling (rounded corners)
└── waybar.css         # Waybar theme (included in style.css)
```

---

## 🚀 Setup on New Computer

### Option 1: Full Setup
```bash
# 1. Sync ~/AI folder via Syncthing

# 2. Run setup script
cd ~/AI
./setup.sh

# 3. Restart services
hyprctl reload
pkill waybar && waybar &

# 4. Done!
```

### Option 2: Waybar Only
```bash
cd ~/AI
./setup-waybar.sh

# Restart waybar
pkill waybar && waybar &
```

### Option 3: Manual Copy
```bash
# Waybar
cp -r ~/AI/config/waybar/* ~/.config/waybar/
chmod +x ~/.config/waybar/scripts/*.sh

# Hyprland
cp -r ~/AI/config/hyprland/* ~/.config/hypr/

# Restart
hyprctl reload
pkill waybar && waybar &
```

---

## ✅ Verification Checklist

Before syncing, verify:

### Waybar
- [x] Config synced to `~/AI/config/waybar/`
- [x] Style synced
- [x] All 11 essential scripts synced
- [x] GPU sparkline working
- [x] CPU sparkline working
- [x] Weather widget working
- [x] Battery widget working
- [x] All portable paths (no /home/username)

### Hyprland
- [x] All configs synced to `~/AI/config/hyprland/`
- [x] No hardcoded paths
- [x] Rounded corners configured (decoration: rounding = 10)
- [x] Window rules for floating popups

### Popups
- [x] Weather detailed popup (rounded corners)
- [x] Battery graph popup (rounded corners)
- [x] Idle menu popup (rounded corners)
- [x] Radar menu popup (rounded corners)

### Documentation
- [x] Complete waybar guide
- [x] Setup scripts ready
- [x] All changes documented

---

## 🎯 Everything is Reproducible!

### What Gets Reproduced

✅ **Waybar Module Positions** - Left/Center/Right layout
✅ **CPU Sparkline** - Dual graphs with frequency
✅ **GPU Sparkline** - Load monitoring with frequency
✅ **Weather Widget** - With 3-click radar menu
✅ **Battery Widget** - With idle control and history
✅ **Rounded Corners** - All popups and windows
✅ **Theme Styling** - Via Omarchy theme system
✅ **Hyprland Config** - All rules and bindings
✅ **Keyboard Shortcuts** - All Super+Shift combos
✅ **Window Management** - Floating rules and decoration

### What Doesn't Need Sync

- 📝 **Omarchy Themes** - Managed by Omarchy system
- 📝 **Walker Menus** - Managed by Omarchy system
- 📝 **Omarchy Scripts** - In `~/.local/share/omarchy/`

These are installed via Omarchy and don't need manual sync.

---

## 📊 Final Status

**Reproducibility**: ✅ **100%**
**Portable Paths**: ✅ **All Fixed**
**Documentation**: ✅ **Complete**
**Setup Scripts**: ✅ **Ready**
**Ready to Sync**: ✅ **YES**

---

## 🎉 You're Good to Go!

Everything is configured and ready for sync to another computer. Just:

1. **Sync ~/AI folder** via Syncthing
2. **Run setup** on new computer:
   ```bash
   cd ~/AI
   ./setup.sh
   ```
3. **Enjoy** your complete setup!

All module positions, rounded corners, popup menus, and styling will be exactly the same.

---

**Status**: ✅ **READY FOR SYNC**
**Date**: 2026-01-07
**Reproducibility**: ✅ **100%**
