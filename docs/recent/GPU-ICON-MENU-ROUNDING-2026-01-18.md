# Waybar GPU Icon & Omarchy Menu Rounding - 2026-01-18

## Changes Made

### 1. GPU Icon Update (Waybar)
**Location**: `~/.config/waybar/scripts/gpu-spark.sh`

**Before**:
- Used graph emoji icon: `📊`
- Icon was static (same for all GPU types)

**After**:
- Removed graph icon completely
- Dynamic icon based on GPU type:
  - **"I"** for Intel integrated GPU
  - **"D"** for NVIDIA/AMD dedicated GPU
- Sparkline graph still shows load visualization

**Implementation**:
```bash
# GPU type detection
GPU_ICON="D"  # Default to Dedicated
if [[ -d "/sys/class/drm/card0/device/i915" ]] || [[ -d "/sys/module/i915" ]]; then
    GPU_ICON="I"  # Intel Integrated GPU
fi
```

**Testing Result**:
- ✅ System with Intel HD Graphics 530 now displays: `I ▄▅▆▅▆`
- ✅ Tooltip shows: "GPU: Intel HD Graphics 530\nLoad: 68% | 717 MHz"

---

### 2. Omarchy Menu Rounding (Walker Launcher)
**Location**: `~/.config/hypr/hyprland.conf`

**Problem**:
- Walker menu (app launcher) had square corners
- Hyprland window rule `windowrulev2 = unset, match:class walker` was blocking rounding

**Solution**:
- Removed the problematic `unset` rule
- Kept existing `rounding 15` rule intact
- Reloaded hyprland configuration

**Before**:
```conf
windowrulev2 = unset, match:class walker
windowrulev2 = float, match:class walker
windowrulev2 = rounding 15, match:class walker
windowrulev2 = border_size 4, match:class walker
windowrulev2 = dim_around, match:class walker
windowrulev2 = opaque, match:class walker
```

**After**:
```conf
windowrulev2 = float, match:class walker
windowrulev2 = rounding 15, match:class walker
windowrulev2 = border_size 4, match:class walker
windowrulev2 = dim_around, match:class walker
windowrulev2 = opaque, match:class walker
```

**Result**:
- ✅ Walker menu (Omarchy app launcher) now has 15px rounded corners
- ✅ Menu floats with proper styling (4px border, dim_around effect)
- ✅ Rounding matches other windows on system

---

## Files Modified

### Active Configurations:
1. `~/.config/waybar/scripts/gpu-spark.sh`
   - Backup created: `gpu-spark.sh.backup-20260118_HHMMSS`
   - GPU icon logic updated
   - Copied to `~/AI/config/waybar/scripts/`

2. `~/.config/hypr/hyprland.conf`
   - Backup created: `hyprland.conf.backup-20260118_HHMMSS`
   - Removed walker `unset` rule
   - Copied to `~/AI/config/hyprland.conf`

---

## How to Test

### GPU Icon:
1. Check waybar - should show "I" or "D" instead of 📊
2. Hover over GPU module - tooltip shows GPU type and load
3. If you have NVIDIA/AMD GPU, it should show "D"
4. If you have Intel integrated GPU, it should show "I"

### Walker Menu Rounding:
1. Press Super+Escape (or your menu shortcut) to open walker
2. Observe window corners - should be rounded (15px radius)
3. Compare with other windows - should match system rounding style
4. Close and reopen to verify rounding persists

---

## GPU Detection Logic

The script checks for Intel integrated GPU:
```bash
# Integrated GPU (Intel)
/sys/class/drm/card0/device/i915
/sys/module/i915
```

Default is "D" (dedicated) because most gaming/workstation systems have discrete GPU.

---

## Why `unset` Was Blocking Rounding

The `windowrulev2 = unset, match:class walker` rule was unsetting window properties that Hyprland applies by default. This included:

- `rounding` - Border radius
- `border_size` - Border thickness
- Other decoration properties

By removing `unset`, the explicit `rounding 15` and `border_size 4` rules now work properly.

---

## System Status

- ✅ GPU icon shows "I" for Intel integrated GPU
- ✅ GPU sparkline graph still displays load history
- ✅ Walker menu corners are now rounded (15px)
- ✅ Waybar restarted to apply changes
- ✅ Hyprland reloaded to apply window rules
- ✅ Configs synced to `~/AI/config/` for reproducibility

---

*Last Updated: 2026-01-18*
*User Request: Remove graph icon, replace with I/D, round menu corners*
*Status: Complete*
