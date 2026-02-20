# System Parameters

## System Configuration & Parameters

### 2025-11-25
- Created this file to track system parameters and configurations
- Weather widget project completed and moved to projects folder
- This file now serves as central system parameter tracking

---

## Current System Setup

### Desktop Environment
- **Window Manager**: Hyprland
- **Status Bar**: Waybar
- **Theme System**: Omarchy
- **Terminal**: Default terminal with TUI support

### Location & Geography
- **City**: Whitecourt, Alberta, Canada
- **Coordinates**: 54.15°N, -115.68°W
- **Timezone**: GMT (currently)
- **Weather API**: Open-Meteo

### Hardware Specifications
- **Temperature Sensor**: /sys/class/hwmon/hwmon7/temp1_input
- **CPU Monitoring**: Available via btop integration
- **Battery**: Present with capacity monitoring
- **Bluetooth**: Available and configured
- **Network**: WiFi and Ethernet support

### Waybar Configuration
- **Position**: Top
- **Height**: 23px
- **Modules**: Custom weather, workspaces, system indicators
- **Update Intervals**: Weather (30min), CPU (5s), Network (3s)

### Clipboard Configuration
- **Auto-Copy**: ✅ Complete (Terminal working, Browser limited)
- **Tools**: cliphist + wl-clipboard + elephant-clipboard
- **Script**: `~/.config/hypr/scripts/autoclip.sh` (loop-based monitoring)
- **Terminal**: Highlight text → auto-copies to clipboard + Walker history
- **Browser**: Only middle-click works (security limitation)
- **Project**: `doc-sync/AI/projects/hypr/clipboard/clipboard auto-copy.md`

### Weather Widget Configuration
- **API**: Open-Meteo (free, no key required)
- **Location**: Whitecourt, AB (54.15°N, -115.68°W)
- **Features**: Real-time weather, icons, detailed tooltips (temp/humidity/wind/condition), 3-day forecast popup
- **Click Events**:
  - Left: Detailed popup with current conditions and forecast
  - Middle: MSN weather forecast page
  - Right: Radar menu with 7 options + all
- **Radar Menu Options**:
  1. 🌧️ RainViewer - Global radar
  2. 🌪️ Windy - Interactive weather map
  3. 📡 AccuWeather - Local radar
  4. 🌤️ MSN Weather - Whitecourt forecast
  5. 📰 CTV News - Edmonton weather
  6. 📰 Global News - Edmonton weather
  7. 🛰️ Environment Canada - Western Canada satellite
  8. 🚀 Open all (7 tabs)
- **Scripts**: `~/.config/waybar/scripts/weather.sh` and `weather-detailed.sh`
- **Backup**: Available in `backups/` for reproducibility

### Package Management
- **AUR Helper**: Paru with custom configuration
- **Key Settings**: BottomUp search, CleanAfter, Devel package support
- **Config Location**: `~/.config/paru/paru.conf`
- **Backup Location**: `doc-sync/Config/RunningCF/Package_Managers/`

### API Services Used
- **Weather**: Open-Meteo (free, no API key)
- **Package Updates**: Omarchy update service
- **System Monitoring**: Local system calls

### Battery History Widget Configuration
- **Status**: ✅ Complete with floating window, current session filtering, and power profile integration
- **Right-click**: Opens floating terminal with dual graphs and power profile header
- **Window**: 70% x 50%, centered, floating via Hyprland rules
- **Data**: Current session only (today's entries from midnight)
- **Timeline**: Newest data (0 min ago) on left, older on right
- **Features**: 
  - Power profile header using powerprofilesctl (Performance/Balanced/Power Saver)
  - Capacity line graph at top (8 rows high, ● markers)
  - Power consumption bars at bottom (█/░ characters, 0-20W scale)
  - Session filtering (today only via SESSION_START timestamp)
  - Automatic logging every minute via systemd timer
  - Enhanced header shows battery status + system power profile + current watts
- **Files**: `~/.config/waybar/scripts/battery-graph.sh`, `~/.config/waybar/config.jsonc`, `~/.config/hyprland.conf`
- **Troubleshooting**: Fixed AWK syntax errors, Hyprland globbing issues, window sizing, missing bc dependency

### Backup System
- **Scripts**: backup-configs.sh, restore-configs.sh, list-backups.sh
- **Coverage**: Waybar, Hyprland, Kitty, Omarchy themes, system state
- **Automation**: Timestamped backups with latest symlink
- **Reproducibility**: Full config restoration capability

---

## File Structure
See `projects/hypr/README.md` for complete file structure documentation.

## Quick Reference
- **Clipboard Setup**: `projects/hypr/clipboard/clipboard auto-copy.md`
- **Weather Widget**: `projects/hypr/weather widget.md`
- **Package Manager**: `projects/hypr/package managers.md`
- **Hyprland Overview**: `projects/hypr/hyprland config.md`

---

## Dependencies
- **Core**: curl, jq, waybar, hyprland
- **Package Management**: paru, pacman
- **Clipboard**: cliphist, wl-clipboard, elephant-clipboard
- **Scripts**: bash, standard Unix tools
- **Monitoring**: btop, wiremix (audio)
- **Network**: NetworkManager, bluetoothctl

---

## Documentation Guidelines
- **IMPORTANT**: Always update parameters as they change or add to it as different components are used
- Update this file if anything relevant comes up during system usage
- The md file or files are to be updated as we move forward
- All configurations are tracked in doc-sync/AI/ for reference
- Project-specific details moved to projects/ subfolder
- System parameters centralized in this file
- Regular updates recommended after system changes

---

## Notes
- Weather widget enhanced with advanced radar menu and detailed tooltips
- Backup system integrated for full system reproducibility
- All configurations backed up in `doc-sync/AI/backups/` with restore capability
- System parameters updated with current weather widget and backup details
- Documentation structure: `doc-sync/AI/` for system info, `doc-sync/AI/projects/` for specific projects
- Configuration backups maintained in `doc-sync/Config/RunningCF/` and `doc-sync/AI/backups/`