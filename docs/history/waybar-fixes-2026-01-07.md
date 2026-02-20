# Waybar Fixes - 2026-01-07

**Problem**: After fixing hardcoded paths yesterday, waybar was missing GPU graphs, weather widget, and battery icon due to double `.config/.config/` paths.

---

## ✅ Fixes Applied

### 1. **GPU Graphs** - ✅ NEWLY CREATED
- Created `~/.config/waybar/scripts/gpu-spark.sh`
- Monitors Intel HD Graphics 530 GPU frequency and load
- Displays sparkline showing GPU activity over time
- Shows current MHz in tooltip
- Added to waybar right side between pulseaudio and CPU

**Output Example**:
```json
{"text":"🎮 ▄▅▃▆","tooltip":"GPU: 77% | 817 MHz"}
```

**Features**:
- 4-point sparkline history
- Updates every 2 seconds
- Click to view detailed info
- Uses GPU frequency ratio for load percentage

---

### 2. **Weather Widget** - ✅ FIXED
**Problem**: Double `.config/.config/` paths in config.jsonc preventing script execution

**Fixed**:
- Corrected path from `~/.config/.config/waybar/scripts/weather.sh` to `~/.config/waybar/scripts/weather.sh`
- All three click handlers updated (left, middle, right)

**Status**: Now showing ☀️ -5.2°C with full interactivity

**Features**:
- **Left Click**: Opens detailed weather popup with 3-day forecast
- **Middle Click**: Opens Windy.com radar for Whitecourt, AB
- **Right Click**: Interactive radar menu with 7 sources
- **Hover**: Current conditions display

---

### 3. **Battery Icon** - ✅ FIXED
**Problem**: Double `.config/.config/` paths causing errors

**Fixed in two files**:
1. `~/.config/waybar/config.jsonc`
   - Fixed `exec` path for custom-battery.sh
   - Fixed `on-click-middle` path for sleep-interrupt-menu.sh

2. `~/.config/waybar/scripts/custom-battery.sh`
   - Fixed line 50 path for idle-controller.sh

**Status**: Now showing 󰁹 with 90% charge and 3.1h remaining

**Features**:
- Shows battery icon based on charge level
- Displays power consumption (13.0W↓)
- Shows time remaining (3.1h)
- **Left Click**: Opens power menu
- **Middle Click**: Opens idle timeout control menu
- **Right Click**: Opens battery history graph

---

## 🔧 Files Modified

### Waybar Config
- `~/.config/waybar/config.jsonc` - Fixed all double `.config/.config/` paths, added gpu-spark module

### Scripts Created/Modified
- `~/.config/waybar/scripts/gpu-spark.sh` - **NEW** - GPU monitoring script
- `~/.config/waybar/scripts/custom-battery.sh` - Fixed path on line 50

### AI Config (For syncing to other machines)
- `~/AI/config/waybar/config.jsonc` - Updated with all fixes
- `~/AI/config/waybar/scripts/gpu-spark.sh` - **NEW** - Added to backup

---

## 🚀 How to Apply to Another Computer

### Option 1: Quick Copy
```bash
# Copy complete waybar config
cp -r ~/AI/config/waybar/* ~/.config/waybar/
chmod +x ~/.config/waybar/scripts/*.sh

# Restart waybar
pkill waybar && waybar &
```

### Option 2: Use Setup Script
```bash
cd ~/AI
./setup.sh
```

---

## 📊 Current Waybar Module Layout (Right Side)

```
[weather] [tray] [temp] [bt] [net] [audio] [🎮GPU] [cpu] [battery]
```

- **weather**: ☀️ -5.2°C with click actions
- **tray**: System tray with expander
- **temp**: System temperature (CPU) in Celsius
- **bt**: Bluetooth status
- **net**: Network connection
- **audio**: Pulseaudio volume
- **🎮GPU**: GPU sparkline with load percentage (NEW!)
- **cpu**: CPU icon (click for btop)
- **battery**: Battery with charge, power, and time remaining

---

## ⚠️ GPU Monitoring Notes

### Hardware Detected
- **Primary GPU**: Intel HD Graphics 530 (integrated)
- **Discrete GPU**: Radeon (not actively monitored)

### Monitoring Method
- Uses GPU frequency from `/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt_cur_freq_mhz`
- Calculates load percentage based on current/max frequency ratio
- If GPU frequency unavailable, shows "Checking..." tooltip

### Limitations
- Only monitors Intel integrated GPU (card2)
- Radeon discrete GPU not monitored (sensor unavailable)
- Load is estimated from frequency, not actual GPU utilization

---

## 🐛 Troubleshooting

### Weather Not Showing
```bash
# Test weather script
~/.config/waybar/scripts/weather.sh

# Should return: {"text":"☀️ -5°C","tooltip":"..."}
```

### Battery Not Working
```bash
# Test battery script
~/.config/waybar/scripts/custom-battery.sh

# Should return: {"text":"󰁹","tooltip":"90% 13.0W↓ | 3.1h"}
```

### GPU Not Showing
```bash
# Test GPU script
~/.config/waybar/scripts/gpu-spark.sh

# Should return: {"text":"🎮 ▄▅▃▆","tooltip":"GPU: 77% | 817 MHz"}
```

### Waybar Not Restarting
```bash
# Kill all waybar processes
pkill waybar

# Start fresh
waybar

# Check for errors
journalctl --user -u waybar -f
```

---

## ✅ Verification

All three components tested and working:
- ✅ GPU sparkline: Shows activity and frequency
- ✅ Weather widget: Shows temperature with all click actions
- ✅ Battery icon: Shows charge, power, and time remaining

---

**Date**: 2026-01-07
**Issue**: Missing GPU graphs, weather widget, and battery icon after path fix
**Status**: ✅ **ALL FIXED**
**Ready for sync to other computers**: ✅ **YES**
