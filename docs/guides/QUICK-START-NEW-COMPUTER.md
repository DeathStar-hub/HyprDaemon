# Quick Start Guide for New Computer

**For Fresh Setup After Syncing ~/AI Folder**

---

## 🚀 Step-by-Step Setup

### 1. Sync ~/AI Folder
Ensure your `~/AI` folder has been synced via Syncthing to the new computer.

### 2. Tell the AI Assistant

Start a conversation with AI and tell it:

> **"This is a new computer, please read ~/AI and run all setup scripts"**

The AI will then:
1. ✅ Read `PROJECT_PROGRESS.md` for system context
2. ✅ Run `~/AI/cleanup-sessions.sh` automatically
3. ✅ Read all session files for full context
4. ✅ Execute `./setup.sh` to reproduce all configurations
5. ✅ Restart services (hyprland, waybar)
6. ✅ Verify everything is working

### 3. What Setup Script Does

Automatically copies and configures:

#### Waybar (12 modules)
- ✅ CPU sparkline (dual graphs, no background)
- ✅ GPU sparkline (load monitoring, 📊 icon, no background)
- ✅ Weather widget (3-click radar menu)
- ✅ Battery widget (idle control + history graph)
- ✅ Clock (transparent, no background)
- ✅ Temperature (frosted glass background)
- ✅ All other modules (tray, bluetooth, network, audio, etc.)

#### Hyprland (11 config files)
- ✅ hyprland.conf (main config)
- ✅ looknfeel.conf (rounded corners = 10px)
- ✅ bindings.conf (all Super+Shift shortcuts)
- ✅ autostart.conf (auto-start processes)
- ✅ All other configs (idle, lock, input, monitors, etc.)

#### Terminal
- ✅ kitty.conf (window padding, font, styling)
- ✅ Includes omarchy themes automatically

#### Other
- ✅ Ranger file associations
- ✅ Battery logging service
- ✅ All scripts made executable
- ✅ Paths adapted to current username

### 4. After Setup Completes

The AI will restart services and verify:

```bash
hyprctl reload
pkill waybar && waybar &
```

**You should see:**
- ✅ Waybar with CPU and GPU sparklines (no background)
- ✅ Weather widget with current temperature
- ✅ Battery with charge and time remaining
- ✅ All windows with rounded corners (10px)
- ✅ All keyboard shortcuts working

### 5. Test Everything

#### Test Waybar Modules
```
Left side:
[workspaces] [CPU ▂▂▁▂ ▁▁▁] [📊 ▅▄▆▅]
```
- ✅ CPU sparkline showing (dual graphs)
- ✅ GPU sparkline showing (📊 icon)
- ✅ Click each to verify

**Click Actions:**
- **Weather**: Left-click (detailed popup), Right-click (radar menu)
- **Battery**: Middle-click (idle menu), Right-click (history graph)
- **CPU/GPU**: Hover for tooltips

#### Test Popups
- ✅ Left-click weather → Should see 3-day forecast popup
- ✅ Right-click battery → Should see battery history graph
- ✅ Middle-click battery → Should see idle timeout menu
- ✅ Right-click weather → Should see radar source menu

**All popups should have rounded corners!**

#### Test Keyboard Shortcuts
Try these Super+Shift combos:
- `Super+Shift+Return` → Terminal
- `Super+Shift+O` → Opencode (in ~/AI)
- `Super+Shift+F` → File manager
- `Super+Shift+B` → Browser
- `Super+Shift+T` → Activity (btop)
- `Super+Shift+M` → Music (spotify)

#### Test Window Rounding
Open any window or popup - should have rounded corners (10px)

---

## 📋 What Gets Installed

```
~/.config/waybar/
├── config.jsonc (12 modules configured)
├── style.css (transparent except temperature)
└── scripts/ (12 scripts)
    ├── gpu-spark.sh (NEW!)
    ├── cpu-spark.sh
    ├── weather.sh
    ├── custom-battery.sh
    └── [8 more scripts]

~/.config/hypr/
├── hyprland.conf (main config)
├── looknfeel.conf (rounded corners)
├── bindings.conf (all shortcuts)
└── [8 more config files]

~/.config/kitty/
└── kitty.conf (terminal config)
```

---

## ✅ Verification Checklist

After setup completes, check:

Waybar
- [ ] CPU sparkline showing (no background)
- [ ] GPU sparkline showing (no background, 📊 icon)
- [ ] Weather widget showing temperature
- [ ] Battery widget showing charge
- [ ] Clock transparent
- [ ] Temperature with frosted glass

Windows
- [ ] All windows have rounded corners
- [ ] Popups have rounded corners

Interactivity
- [ ] Weather left-click shows popup
- [ ] Weather right-click shows radar menu
- [ ] Battery right-click shows history graph
- [ ] Battery middle-click shows idle menu
- [ ] All keyboard shortcuts work

Services
- [ ] Hyprland loaded
- [ ] Waybar running
- [ ] Battery logging active

---

## 🎯 That's It!

Just tell the AI:
> "This is a new computer, please read ~/AI and run all setup scripts"

And everything will be set up exactly the same as your main computer!

---

**Last Updated**: 2026-01-07
**Status**: ✅ Ready for deployment
