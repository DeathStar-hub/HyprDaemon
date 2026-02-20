# Battery History Widget Project

## Overview
Add right-click functionality to the Waybar battery module to display a graph of battery power consumption history and capacity trend.

## Current Status
- ✅ **COMPLETED** - Battery module shows watts and % in tooltip
- ✅ **COMPLETED** - Right-click opens floating terminal with dual graphs:
  - Power consumption bars (last 30 minutes, current session only)
  - Capacity line graph (last 30 minutes, current session only)
- ✅ **COMPLETED** - Automatic logging every minute via systemd timer
- ✅ **COMPLETED** - Floating window configuration (70% x 50%, centered)
- ✅ **COMPLETED** - Current session filtering (today's data only)
- ✅ **COMPLETED** - Power profile header using powerprofilesctl integration
- ✅ **COMPLETED** - Enhanced display with system power profile (Performance/Balanced/Power Saver)

## Implementation Plan
1. ✅ Ensure battery logging is active (sample data created for testing)
2. ✅ Modify Waybar config to add on-click-right handler
3. ✅ Test the popup display (right-click battery icon)
4. ✅ Add Hyprland rules for floating window
5. ✅ Set up automatic logging (systemd timer every 1 minute)
6. ✅ Move power consumption bars to bottom of display
7. ✅ Filter data to current session only (today's entries)
8. ✅ Configure floating window sizing and positioning

## Files
- `~/.config/waybar/scripts/battery-log.sh` - Logs power consumption
- `~/.config/waybar/scripts/battery-graph.sh` - Displays the graph (updated)
- `~/.config/systemd/user/battery-log.timer` - Timer for logging
- `~/.config/systemd/user/battery-log.service` - Service for logging
- `~/.cache/battery_history.log` - Log file
- `~/.config/waybar/config.jsonc` - Waybar config with right-click handler (updated)
- `~/.config/hyprland.conf` - Hyprland config with floating window rules (updated)

## Requirements
- Battery power sensor at `/sys/class/power_supply/BAT0/power_now`
- bc calculator for floating point
- Kitty terminal for popup

## Troubleshooting & Issues Resolved

### Issues Encountered:
1. **Hyprland globbing error**: `found no match` error due to missing `windows.conf`
   - **Solution**: Removed the `source = ~/.config/hypr/windows.conf` line from hyprland.conf
   - **Command**: `ls -la ~/.config/hypr/windows.conf` confirmed file didn't exist

2. **AWK syntax error**: `END { ^ syntax error` in battery-graph.sh
   - **Cause**: Accidentally split END block when editing array reversal logic
   - **Solution**: Rewrote complete AWK scripts with proper END blocks

3. **Time axis direction confusion**: Timeline showing wrong direction
   - **Issue**: User preferred newest data on left, older on right (reverse chronological)
   - **Attempted**: Added array reversal logic to show oldest→newest
   - **Final**: Removed reversal to maintain newest→oldest direction as preferred

4. **Window sizing issues**: Graph display affected by window size
   - **Initial**: 50% x 60% window caused display issues
   - **Final**: Changed to 70% x 50% for better visibility

5. **Session filtering**: Data from previous day still showing
   - **Issue**: `tail -n 30` included old data despite filtering
   - **Solution**: Added `SESSION_START=$(date -d "$(date +%Y-%m-%d) 00:00:00" +%s)` and proper filtering

6. **Missing bc calculator**: Battery script failed without bc
   - **Issue**: `bc: command not found` error during power calculation
   - **Solution**: User installed bc package with `paru -S bc`
   - **Note**: Temporary awk workaround was implemented, then reverted to bc after installation

7. **Timeline display issue**: Capacity graph not showing full 30-minute span
   - **Issue**: Dots only appeared at actual data points, leaving gaps in timeline
   - **Solution**: Fixed graph to use fixed 30-minute timeline with proper positioning
   - **Result**: Timeline now spans 0-30 minutes with dots at correct time intervals

8. **Timeline clustering and width issues**: Dots clustered, timeline too wide
   - **Issue**: Timeline showed wrong time ranges and was too wide for window
   - **Solution**: Multiple iterations to fix time positioning and condense width
   - **Result**: Perfect 30-minute span with proper spacing and condensed width

9. **Window behavior issues**: Auto-close and focus problems
   - **Issue**: Window closed immediately, didn't focus at top
   - **Solution**: Removed auto-close, added manual keypress, implemented auto-scroll to top
   - **Result**: Window stays open, shows capacity graph immediately, closes on keypress

10. **Power profile positioning**: Header at wrong location
   - **Issue**: Power profile header at very top instead of between graphs
   - **Solution**: Moved power profile header between capacity and consumption graphs
   - **Result**: Perfect layout flow with logical information hierarchy

### Commands Used for Testing:
```bash
# Check hyprland logs
journalctl -u hyprland --since "5 minutes ago" | tail -20

# Check file existence
ls -la ~/.config/hypr/windows.conf

# Test script directly
~/.config/waybar/scripts/battery-graph.sh

# Reload configurations
hyprctl reload
pkill waybar && waybar &

# Copy updated configs
cp ~/AI/config/waybar/scripts/battery-graph.sh ~/.config/waybar/scripts/
cp ~/AI/config/waybar/config.jsonc ~/.config/waybar/
cp ~/AI/config/hyprland/hyprland.conf ~/.config/hypr/
```

### Final Configuration Details:
- **Window Title**: `Battery*` (matches pattern for floating rules)
- **Window Size**: 70% width x 50% height
- **Position**: Centered on screen
- **Data Source**: Last 30 entries from `~/.cache/battery_history.log`
- **Time Range**: Current session only (today's entries from midnight)
- **Update Interval**: Every 30 minutes for display, 1 minute for logging
- **Timeline Direction**: Newest (0 min ago) on left, older on right
- **Power Profile Integration**: Uses powerprofilesctl to show system power profile
- **Enhanced Header**: Shows battery status + system power profile + current watts
- **Layout Order**: Battery capacity graph on top, power consumption bars on bottom (user preference)

## Reproduction Steps:
1. Ensure battery logging is active: `systemctl --user status battery-log.timer`
2. Right-click battery icon in Waybar
3. Floating window should appear with:
   - Capacity line graph at top
   - Power consumption bars at bottom
   - Current session data only
   - Proper time axis (0 min ago on left)

## Status: ✅ COMPLETE AND WORKING AS REQUESTED
All requested features implemented and working perfectly. Right-click battery functionality delivers the desired graph layout and behavior. Project ready for production use and fully reproducible.

**Layout Enhancement (2025-12-08):**
- ✅ Battery capacity graph moved to top
- ✅ Power consumption bars moved to bottom
- ✅ User layout preference implemented
- ✅ All functionality tested and working

**Timeline and Display Optimization (2025-12-08):**
- ✅ Fixed timeline to show proper 30-minute span (30m → 0m)
- ✅ Optimized dot spacing across full timeline
- ✅ Condensed width for better fit in floating window
- ✅ Limited power consumption height while maintaining full 30-minute data
- ✅ Removed auto-close behavior, added manual keypress
- ✅ Added auto-scroll to top for immediate capacity graph visibility
- ✅ Repositioned power profile header between graphs
- ✅ Perfect layout: Capacity (top) → Power Profile (middle) → Consumption (bottom)</content>
<parameter name="filePath">/home/nemesis/AI/battery-history-widget/README.md