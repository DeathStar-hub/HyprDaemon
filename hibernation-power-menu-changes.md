# Hibernation & Power Menu Customization

## Changes Made

### 1. Idle Auto-Suspend (hypridle.conf)

**File:** `~/.config/hypr/hypridle.conf`

Added idle suspend listener that triggers after 20 minutes of inactivity:

```bash
listener {
    timeout = 1200                                           # 20min
    on-timeout = systemctl suspend-then-hibernate            # suspend after idle (hibernate if enabled)
}
```

**Idle timeline:**
- 2.5 min → Screensaver starts
- 5 min → Screen locks
- 5.5 min → Display turns off
- **20 min → System suspends (NEW)**

**Note:** If hibernation is enabled, this will suspend-then-hibernate (sleep for 30 min, then hibernate to disk).

---

### 2. System Menu Reordering (Power Menu)

**File:** `~/.config/omarchy/extensions/menu.sh`

Created override to reorder the System menu (`SUPER+A` → System):

**New Order:**
1. 󰤁  Hibernate (if enabled)
2. 󰐥  Shutdown
3.   Lock
4. 󱄄  Screensaver
5. 󰒲  Suspend (if enabled via `omarchy-toggle-suspend`)
6. 󰜉  Restart

**Previous Order:**
1. Lock
2. Screensaver
3. Suspend
4. Hibernate
5. Restart
6. Shutdown

---

## How to Enable Hibernation

To use hibernation, you must first set it up:

```bash
omarchy-hibernation-setup
```

This creates:
- Btrfs swapfile matching your RAM size
- systemd suspend-then-hibernate configuration
- Lid-close behavior (close lid → suspend → hibernate after 30 min)

**Check if hibernation is available:**
```bash
omarchy-hibernation-available
```

**Remove hibernation:**
```bash
omarchy-hibernation-remove
```

---

## Power Behavior Summary

### Lid Close
- If hibernation enabled: Suspend immediately, hibernate after 30 min
- If hibernation disabled: Suspend only

### Idle (20 min)
- If hibernation enabled: Suspend immediately, hibernate after 30 min
- If hibernation disabled: Suspend only

### Hibernate vs Suspend

| Feature | Suspend (Sleep) | Hibernate |
|---------|-----------------|-----------|
| Power use | Very low (~1-5W) | **Zero** |
| Wake time | 1-2 seconds | 10-20 seconds |
| Use case | Short breaks | Long periods, travel |

---

### 3. Rounded Corners on Walker Menus

**Files:**
- `~/.config/walker/config.toml` - Changed theme to "omarchy-rounded"
- `~/.config/walker/themes/omarchy-rounded/layout.xml` - Created
- `~/.config/walker/themes/omarchy-rounded/style.css` - Created

Created a custom Walker theme with rounded corners:
- Main window: 12px border radius
- Search box: 8px border radius  
- Menu items: 6px border radius
- Keybind hints: 6px border radius

**Fix Applied (2026-02-20):** Changed CSS import from relative path to absolute path to fix theme colors not loading:
```css
/* Before (broken - white/transparent): */
@import "../../../../../../../.config/omarchy/current/theme/walker.css";

/* After (fixed - proper theme colors): */
@import "/home/nemesis/.config/omarchy/current/theme/walker.css";
```

---

## Files Modified/Created

1. `~/.config/hypr/hypridle.conf` - Added idle suspend listener
2. `~/.config/omarchy/extensions/menu.sh` - Created for menu reordering
3. `~/.config/walker/config.toml` - Changed theme to "omarchy-rounded"
4. `~/.config/walker/themes/omarchy-rounded/layout.xml` - Created
5. `~/.config/walker/themes/omarchy-rounded/style.css` - Created

---

*Documentation created: 2026-02-10*
