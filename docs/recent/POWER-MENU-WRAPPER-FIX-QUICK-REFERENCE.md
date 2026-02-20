# Power Menu Wrapper Fix - Quick Reference

**Status**: ✅ Working
**Date**: 2026-02-02

## Problem
Power menu appears but clicking/selecting options doesn't work when invoked via power button keybinding.

## Root Cause
Commands executed via Hyprland keybindings run in minimal execution context and may not inherit critical environment variables (PATH, DISPLAY, WAYLAND_DISPLAY).

## Solution
Created wrapper script that explicitly sets environment variables before executing menu command.

## Files Modified

### New File
`~/.local/bin/omarchy-power-menu`
```bash
#!/bin/bash
export PATH="$HOME/.local/share/omarchy/bin:$PATH"
export DISPLAY="$DISPLAY"
export WAYLAND_DISPLAY="$WAYLAND_DISPLAY"
omarchy-menu system
```

### Modified File
`~/.config/hypr/bindings.conf`
```conf
bindd = , XF86PowerOff, Power menu, exec, omarchy-power-menu
```

## Troubleshooting Notes

### Why Terminal Invocation Works
When running `omarchy-menu system` in terminal:
- Shell already has full environment
- All variables are set correctly
- Works without issues

### Why Keybinding Failed
When invoked via keybinding:
- Runs in minimal execution context
- Environment variables may be missing
- Walker can't properly handle window focus/click events

### Why Previous Fixes Didn't Work
- **Dimaround toggle** (Jan 28): Addressed symptom (visual effect), not root cause
- **Walker theme import fix** (Feb 2): Separate issue, unrelated to click handling

## Test Command
Press power button (XF86PowerOff) - menu should appear and respond to clicks.

---
