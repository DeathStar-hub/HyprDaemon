# Hyprland Configuration & Projects

## Overview
This directory contains Hyprland-related projects, configurations, and customizations.

## Projects

### Weather Widget (Completed)
- **File**: `weather widget.md`
- **Status**: ✅ Completed
- **Description**: Fixed waybar weather widget and added weather icons
- **Details**: Switched from wttr.in to Open-Meteo API with icon mapping

### Package Manager Configuration
- **File**: `package managers.md`
- **Status**: ✅ Completed  
- **Description**: Paru AUR helper configuration optimization
- **Details**: BottomUp search results, CleanAfter, Devel package support

### Clipboard Auto-Copy (Partially Working)
- **File**: `clipboard/clipboard auto-copy.md`
- **Status**: ⚠️ Partially Working
- **Description**: Automatic clipboard copying when text is highlighted
- **Details**: Ctrl+V works, Omarchy clipboard viewer integration needed
- **Moved**: Detailed project tracking in `clipboard/` subdirectory

---

## Hyprland System Configuration

### Current Setup
- **Window Manager**: Hyprland
- **Status Bar**: Waybar (top position, 23px height)
- **Theme System**: Omarchy
- **Configuration Location**: `~/.config/hypr/`

### Key Components
- **Waybar**: Custom modules including weather widget
- **Omarchy**: Theme management system
- **Scripts**: Various utility scripts in `~/.config/waybar/scripts/`
- **Clipboard**: Auto-copy daemon for primary selection sync

### File Structure
```
~/.config/hypr/
├── hyprland.conf        # Main Hyprland config
├── autostart.conf       # Autostart applications
├── scripts/             # Custom scripts
│   └── autoclip.sh      # Auto-copy daemon
└── (other config files)

~/.config/waybar/
├── config.jsonc         # Waybar configuration
├── scripts/             # Custom scripts
│   ├── weather.sh       # Weather widget
│   └── cpu-spark.sh     # CPU monitoring
└── style.css            # Waybar styling

~/.config/omarchy/
├── current/theme/       # Active theme
└── themes/              # Available themes
```

## Dependencies
- **Core**: hyprland, waybar
- **Clipboard**: wl-clipboard
- **Scripts**: bash, curl, jq
- **Themes**: omarchy theme system
- **Utilities**: btop, wiremix (audio)

## Notes
- All Hyprland projects documented here for reference
- Configuration files backed up in `doc-sync/Config/RunningCF/`
- Weather widget uses Open-Meteo API for Whitecourt, AB location