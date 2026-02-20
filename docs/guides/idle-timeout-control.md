# Idle Timeout Control Documentation

## 🎯 Feature Overview
Added middle-click functionality to the battery/power icon in Waybar to open a TUI menu for controlling idle timeout inhibition. Useful for preventing screen lock during long-running tasks like system updates.

## 📊 Implementation Details

### Changes Made (Updated 2025-12-23)
- **Menu Script**: `config/waybar/scripts/sleep-interrupt-menu.sh` - fzf TUI menu with dynamic options
- **Controller Script**: `config/waybar/scripts/idle-controller.sh` - Handles pause/resume with proper process management
- **Battery Script**: `config/waybar/scripts/custom-battery.sh` - Shows ⏸️ icon and countdown when idle paused
- **Config Update**: Added `on-click-middle` to battery module in `config.jsonc`
- **Idle Control**: Uses systemctl to stop/start hypridle for reliable idle timeout control
- **State Tracking**: State file, timer file, and PID file in `/tmp/` for complete state management

### Technical Specifications
- **Idle Control**: systemctl to stop/start hypridle service (reliable Wayland idle management)
- **Menu Tool**: fzf with dynamic options based on current idle state
- **State Persistence**: Three files in `/tmp/`:
  - `idle_pause_state_$USER` - Tracks paused/active state
  - `idle_pause_until_$USER` - Stores timestamp for timed pauses
  - `idle_pause_timer_pid_$USER` - Tracks background timer process
- **Process Cleanup**: `pkill -9 hypridle` ensures clean restart without duplicates
- **Countdown Display**: Battery bar shows ⏸️ icon when paused, tooltip shows "Idle Paused: Xm Ys remaining"
- **Background Timer**: Background sleep process with PID tracking for automatic resume

### Menu Options
- **When Idle Active**: "Pause 5 min", "Pause 10 min", "Pause 30 min", "Pause 1 hour", "Pause indefinitely", "Cancel"
- **When Idle Paused (timed)**: "Resume idle (Xm Ys remaining)", "Cancel (resume and clear)"
- **When Idle Paused (indefinite)**: "Resume idle (indefinite)", "Cancel (resume and clear)"

## 🔧 Reproduction Instructions

### Prerequisites
- hypridle configured and running
- busctl (systemd) available
- fzf installed
- Kitty terminal

### Step-by-Step Implementation

The idle control system is fully implemented and included in `~/AI/setup.sh`. To deploy manually:

1. **Create Sleep Interrupt Menu** (`config/waybar/scripts/sleep-interrupt-menu.sh`):
    - Shows fzf menu with dynamic options based on idle state
    - Directly calls idle-controller.sh actions
    - No fragile /tmp file communication

2. **Create Idle Controller** (`config/waybar/scripts/idle-controller.sh`):
    - Handles pause-5, pause-10, pause-30, pause-60, pause-inf, resume
    - Manages hypridle service with proper cleanup
    - Tracks background timer PIDs for clean shutdown
    - Returns status string for Waybar display

3. **Update Custom Battery Script** (`config/waybar/scripts/custom-battery.sh`):
    - Calls `idle-controller.sh status` to get idle state
    - Shows ⏸️ icon when idle is paused
    - Adds "Idle Paused: Xm Ys" to tooltip

4. **Update Waybar Config** (`config/waybar/config.jsonc`):
    ```jsonc
    "custom/battery": {
      "exec": "~/.config/waybar/scripts/custom-battery.sh",
      "interval": 5,
      "return-type": "json",
      "on-click": "omarchy-menu power",
      "on-click-middle": "~/.config/waybar/scripts/sleep-interrupt-menu.sh",
      "on-click-right": "kitty --title 'Battery History' ~/.config/waybar/scripts/battery-graph.sh"
    },
    ```

3. **Update Waybar Config** (`config/waybar/config.jsonc`):
   Replace the battery module with custom/battery:
   ```jsonc
   "custom/battery": {
     "exec": "~/.config/waybar/scripts/custom-battery.sh",
     "interval": 5,
     "return-type": "json",
     "on-click": "omarchy-menu power",
     "on-click-middle": "~/.config/waybar/scripts/sleep-interrupt-menu.sh",
     "on-click-right": "kitty --title 'Battery History' ~/.config/waybar/scripts/battery-graph.sh"
   },
   ```

4. **Configure Hyprland Window Rules** (`config/hyprland/hyprland.conf`):
   Add window rules for sleep interrupt menu:
   ```ini
   # Sleep interrupt menu floating window
   windowrulev2 = float, title:sleep-interrupt
   windowrulev2 = size 40% 40%, title:sleep-interrupt
   windowrulev2 = center, title:sleep-interrupt
   ```

5. **Reload Waybar**:
   ```bash
   pkill -USR2 waybar
   ```

### Hyprland Integration
Ensure hypridle is configured to respect DBus inhibitors:
```ini
# hypridle.conf should have standard timeout settings
# hypridle implements org.freedesktop.ScreenSaver automatically
```

## 🐛 Troubleshooting

### Common Issues
1. **Menu Doesn't Open**:
    - Verify script is executable: `chmod +x ~/.config/waybar/scripts/sleep-interrupt-menu.sh`
    - Check fzf is installed: `pacman -Q fzf`
    - Test manually: `~/.config/waybar/scripts/sleep-interrupt-menu.sh`

2. **Idle Doesn't Pause**:
    - Ensure hypridle is running: `pgrep hypridle`
    - Test controller: `~/.config/waybar/scripts/idle-controller.sh pause-5`
    - Check status: `~/.config/waybar/scripts/idle-controller.sh status`

3. **Multiple hypridle Processes**:
    - Check count: `pgrep -c hypridle`
    - If >1, run: `pkill -9 hypridle && systemctl --user start hypridle`

4. **State Not Persisting**:
    - Verify temp files exist when paused: `ls /tmp/idle_pause_*_$USER`
    - Check if `/tmp` is writable

5. **Countdown Not Showing**:
    - Restart Waybar: `pkill -USR2 waybar`
    - Check battery script output: `~/.config/waybar/scripts/custom-battery.sh`

### Debug Commands
- Check idle status: `~/.config/waybar/scripts/idle-controller.sh status`
- Test pause for 5 minutes: `~/.config/waybar/scripts/idle-controller.sh pause-5`
- Resume idle: `~/.config/waybar/scripts/idle-controller.sh resume`
- Check temp state files: `ls -l /tmp/idle_pause_*_$USER`
- Monitor hypridle: `systemctl --user status hypridle`

## 📈 Performance Impact
- **CPU/Memory**: Minimal (one DBus call per action)
- **Dependencies**: Requires busctl, fzf, Kitty
- **Persistence**: State survives Waybar restarts via temp file

## 🔄 Compatibility
- **Compositors**: Hyprland with hypridle
- **Idle Managers**: Any implementing org.freedesktop.ScreenSaver
- **Terminals**: Kitty (can be adapted for others)

## ✅ Status: Complete and Fixed (2025-12-23)

### Issues Resolved
- **Fixed**: Countdown now properly displays in battery tooltip with "Idle Paused: Xm Ys remaining"
- **Fixed**: Menu options change dynamically based on idle state (pause options when active, resume/cancel when paused)
- **Fixed**: Direct execution without fragile /tmp file communication - actions execute immediately
- **Fixed**: Hypridle cleanup - properly kills duplicate processes before starting new ones
- **Fixed**: Timer process tracking - PIDs saved and properly killed on resume
- **Fixed**: Battery icon shows ⏸️ indicator when idle is paused

### Technical Improvements
- **State Management**: Cookie file for inhibition, timer file for end time, PID file for background timer
- **Process Cleanup**: `pkill -9 hypridle` ensures clean restart without duplicates
- **Status Command**: `idle-controller.sh status` returns formatted string for Waybar
- **Direct Menu**: fzf menu calls controller directly, no intermediate file needed
- **Countdown Display**: Battery tooltip shows remaining time when paused

## 📝 Notes for Future AI
- **Idle Control Method**: Uses systemctl to stop/start hypridle service (reliable for Wayland)
- **Menu Interaction**: fzf with direct execution, no intermediate files or race conditions
- **State Files**: Three files in /tmp/ for state, timer, and PID tracking
- **Process Management**: Always kill existing hypridle before starting new ones
- **Background Timers**: PID files allow clean shutdown of timer processes
- **Status Display**: `idle-controller.sh status` returns formatted string for Waybar
- **Battery Integration**: custom-battery.sh calls status command for icon and tooltip updates

### Sleep Menu Characteristics
The sleep interrupt menu uses fzf in a compact kitty window with Catppuccin theme:
- **Terminal**: Kitty with floating window rules
- **Window Title**: "sleep-interrupt"
- **Size**: 310x245 pixels (28% x 35% of screen)
- **Position**: Centered on screen
- **Font Size**: 11pt
- **Visual**: Double border, Catppuccin Mocha colors (purple/cyan theme)
- **Border Label**: " Sleep Control "
- **Prompt**: "💤  "
- **Height**: Auto (20 rows, fits all options without scrolling)
- **Options** (when active): ⏸️ 5 minutes, ⏸️ 10 minutes, ⏸️ 30 minutes, ⏸️ 1 hour, ⏸️ Indefinitely, ❌ Cancel
- **Options** (when paused): ▶️ Resume (with countdown), ❌ Cancel
- **Window Effects**: No blur, no shadow, 15px rounding, 4px border, dimaround focus, opaque

### Setup Automation
The sleep interrupt menu is automatically configured in the main setup script:
- Scripts copied to `~/.config/waybar/scripts/`
- Window rules added to Hyprland config
- Permissions set for executable files
- Menu configuration fully reproducible

---
*Implementation Date: 2025-12-21*
*Fixed: 2025-12-23 - Resolved all race conditions, process management, and countdown issues*
*Status: Complete - Full functionality with reliable idle control via systemctl*
*Dependencies: fzf, hypridle, systemctl, kitty, notify-send*
*Files Updated: sleep-interrupt-menu.sh, idle-controller.sh, custom-battery.sh, config.jsonc*
*Features: Dynamic menu, timed pauses, countdown display, process cleanup, status tracking*</content>
<parameter name="filePath">/home/nemesis/AI/idle-timeout-control.md