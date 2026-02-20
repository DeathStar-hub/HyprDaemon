# Hyprland Projects

## Overview
This directory contains all Hyprland-related projects, configurations, and customizations for the desktop environment.

## Project Status

### ✅ Completed Projects

#### 📋 Clipboard Auto-Copy
- **File**: `clipboard/clipboard auto-copy.md`
- **Status**: ✅ Complete (Terminal working, Browser limited)
- **Description**: Automatic clipboard copying when text is highlighted
- **Features**: 
  - Terminal highlight → auto-copy to clipboard + Walker history
  - Ctrl+V paste functionality
  - Walker (Super+Ctrl+V) integration with cliphist
  - Middle-click primary selection support
- **Limitations**: Browser only supports middle-click (security)

#### 🌤️ Weather Widget
- **File**: `weather widget.md`
- **Status**: ✅ Complete
- **Description**: Fixed waybar weather widget with icons
- **Features**:
  - Switched from wttr.in to Open-Meteo API
  - Weather condition icons (sun, clouds, rain, etc.)
  - Whitecourt, AB location support
  - 30-minute update intervals

#### 📦 Package Managers
- **File**: `package managers.md`
- **Status**: ✅ Complete
- **Description**: Paru AUR helper configuration optimization
- **Features**:
  - BottomUp search results
  - CleanAfter automatic cleanup
  - Development package support
  - Space-saving optimizations

### 📋 System Overview
- **File**: `hyprland config.md`
- **Status**: 📖 Documentation
- **Description**: Hyprland system configuration and components overview

#### ⌨️ Virtual Keyboard (External Project)
- **Location**: `../virt Kybrd- wvkbd/`
- **Status**: 📂 Project Files
- **Description**: wvkbd configuration for Omarchy Hyprland
- **Contents**: HTML configuration guide and assets

## System Components

### Core Setup
- **Window Manager**: Hyprland (Wayland compositor)
- **Status Bar**: Waybar (top position, 23px height)
- **Theme System**: Omarchy with multiple themes
- **Terminal**: Kitty with copy-on-select enabled
- **Application Launcher**: Walker with clipboard integration

### Key Dependencies
- **cliphist**: Clipboard history manager
- **wl-clipboard**: Wayland clipboard tools
- **elephant-clipboard**: Walker clipboard backend
- **curl, jq**: API and JSON processing
- **paru**: AUR package helper

## File Structure
```
~/.config/hypr/
├── hyprland.conf        # Main Hyprland config
├── autostart.conf       # Autostart applications
└── scripts/
    └── autoclip.sh      # Auto-copy daemon

~/.config/waybar/
├── config.jsonc         # Waybar configuration
├── scripts/
│   ├── weather.sh       # Weather widget
│   └── cpu-spark.sh     # CPU monitoring
└── style.css            # Waybar styling

~/.config/kitty/
└── kitty.conf           # Terminal with copy_on_select

~/.config/paru/
└── paru.conf            # AUR helper configuration
```

## Usage Notes
- All projects include complete replication guides
- Configuration backups maintained in `doc-sync/Config/RunningCF/`
- System parameters tracked in `../model parameters.md`
- Each project file contains troubleshooting and dependency information

## 🔧 Troubleshooting

**If waybar setup doesn't work smoothly**, see: `waybar-troubleshooting.md`

- Quick turnkey setup commands
- Weather widget not working fixes
- Temperature sensor path corrections
- Common issues and solutions

---
*Last Updated: 2025-12-02*