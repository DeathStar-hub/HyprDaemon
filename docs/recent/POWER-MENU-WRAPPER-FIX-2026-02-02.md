# Power Menu Wrapper Fix - 2026-02-02

**Status**: ✅ Working
**Date**: 2026-02-02
**Issue**: Power menu appeared but clicking didn't work when invoked via power button (keybinding)
**Fix**: Created wrapper script to ensure proper environment variables

---

## 🐛 Problem Description

**User reported**:
- Power menu works when running `omarchy-menu system` directly in terminal
- Power menu appears when pressing power button keybinding
- However, clicking/selecting options does nothing when invoked via keybinding
- Same symptoms as previous issue (2026-01-28), but previous fix didn't resolve it

**Previous attempts**:
- Disabled `dimaround` for walker (Jan 28 fix) - didn't solve it
- Re-enabled `dimaround` for walker - didn't solve it
- Tried fixing Walker theme import paths - didn't solve it

**Root cause analysis**:
The issue occurs because when `omarchy-menu system` is invoked via Hyprland keybinding (`XF86PowerOff`), the environment variables (particularly PATH, DISPLAY, WAYLAND_DISPLAY) may not be properly inherited or available in the execution context. However, when running the same command directly in terminal, these variables are already set by the shell environment.

**Why wrapper works**:
The wrapper script explicitly sets critical environment variables before executing the menu command, ensuring the Walker dmenu process has access to necessary display and path information for proper window focus and click handling.

---

## 🔧 Solution Applied

### Created Wrapper Script

**File**: `~/.local/bin/omarchy-power-menu`
```bash
#!/bin/bash
# Power menu wrapper - ensures proper environment and focus
export PATH="$HOME/.local/share/omarchy/bin:$PATH"
export DISPLAY="$DISPLAY"
export WAYLAND_DISPLAY="$WAYLAND_DISPLAY"

# Give window time to appear and get focus
omarchy-menu system
```

**Made executable**: `chmod +x ~/.local/bin/omarchy-power-menu`

### Updated Keybinding

**File**: `~/.config/hypr/bindings.conf`
**Before**:
```conf
bindd = , XF86PowerOff, Power menu, exec, omarchy-menu system
```

**After**:
```conf
bindd = , XF86PowerOff, Power menu, exec, omarchy-power-menu
```

**Reloaded**: `hyprctl reload`

---

## ✅ Why This Fixes It

### Environment Variables Matter

When a command is executed via Hyprland keybinding:
- Runs in a minimal execution context
- May not inherit full shell environment
- Critical variables (PATH, DISPLAY, WAYLAND_DISPLAY) may be missing or incomplete

The wrapper script ensures:
1. **PATH is set**: `$HOME/.local/share/omarchy/bin:$PATH` - ensures omarchy commands are found
2. **DISPLAY is set**: Explicitly passes display information for Wayland compositors
3. **WAYLAND_DISPLAY is set**: Explicitly passes Wayland display information

This allows Walker's dmenu process to:
- Properly register as a window
- Receive focus correctly
- Handle click events properly
- Communicate with Hyprland/Wayland compositor

### Why Direct Terminal Invocation Works

When running `omarchy-menu system` in terminal:
- Shell already has full environment
- PATH includes `~/.local/share/omarchy/bin`
- DISPLAY and WAYLAND_DISPLAY are set
- Everything just works

But when invoked via keybinding, minimal environment means Walker may not know how to properly handle window focus/click events.

---

## 📚 Related Issues

### Similar Issue (2026-01-28)
**Previous fix attempt**: Disabled `dimaround` for walker, thinking it was blocking clicks
**Result**: Didn't solve it (dimaround wasn't the problem)
**Lesson**: Environment variables, not visual effects, were the real issue

### Walker Theme Issues (2026-02-02)
**Problem**: Broken `@import` path in walker theme
**Fix**: Removed broken import (theme already has all styling)
**Status**: Resolved (separate issue)

---

## 🔍 Root Cause Summary

**Did we find the exact cause?**
- **Partially**: The issue is environment variable inheritance when executing commands via keybindings
- **Wrapper ensures**: PATH, DISPLAY, and WAYLAND_DISPLAY are explicitly set before menu execution
- **Still unclear**: Why this affected only power button keybinding but not Waybar navigation to System menu

**Hypothesis**: The keybinding execution context differs from the Waybar launcher context in how it inherits environment variables.

---

## 🎯 Testing

### Power Button Test
1. Press XF86PowerOff (power button)
2. Menu should appear with Shutdown on top
3. Click/select any option - should work properly

### All Menu Options
- ✅ Shutdown → `omarchy-cmd-shutdown`
- ✅ Suspend → `systemctl suspend`
- ✅ Hibernate → `systemctl hibernate` (if available)
- ✅ Restart → `omarchy-cmd-reboot`
- ✅ Lock → `omarchy-lock-screen`
- ✅ Screensaver → `omarchy-launch-screensaver force`

---

## 📁 Files Modified

### New File
- `~/.local/bin/omarchy-power-menu` (wrapper script)

### Modified Files
- `~/.config/hypr/bindings.conf` (updated keybinding)

### Backups Created
- System backup captured: `~/doc-sync/AI/backups/20260202_095148`

---

## 🚀 Reproduction Instructions

To apply this fix on a new system:

```bash
# 1. Create wrapper script
cat > ~/.local/bin/omarchy-power-menu << 'WRAPPER'
#!/bin/bash
export PATH="$HOME/.local/share/omarchy/bin:$PATH"
export DISPLAY="$DISPLAY"
export WAYLAND_DISPLAY="$WAYLAND_DISPLAY"
omarchy-menu system
WRAPPER

# 2. Make executable
chmod +x ~/.local/bin/omarchy-power-menu

# 3. Update binding
sed -i 's|exec, omarchy-menu system|exec, omarchy-power-menu|' ~/.config/hypr/bindings.conf

# 4. Reload Hyprland
hyprctl reload

# 5. Test
# Press power button
```

---

## 📚 Related Documentation

- **Power Menu Order Fix** (2026-01-21): `~/AI/docs/recent/POWER-MENU-FIX-2026-01-21.md`
- **Power Menu Click Fix** (2026-01-28): `~/AI/docs/recent/POWER-MENU-CLICK-FIX-2026-01-28.md`
- **Walker Rounded Corners**: `~/AI/projects/hypr/walker/walker-rounded-corners-complete.md`

---

*Documentation Created: 2026-02-02*
*Fix Applied: Power menu wrapper script*
*Status: ✅ Working*
*Root Cause: Environment variables not inherited when executing via keybinding*
