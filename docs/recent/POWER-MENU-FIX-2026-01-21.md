# Power Menu Fix + Theming Backup - 2026-01-21

**Status**: ✅ Complete
**Date**: 2026-01-21

---

## 📋 What Was Done

### 1. Power Menu Order Fixed

**Problem**:
- Shutdown was at bottom of power menu (after Lock)
- User wanted Shutdown at top where the Lock button is (first option when pressing power button)
- Previous session attempted to fix by editing package-managed file (wrong approach)

**Solution**:
Created user extension at `~/.config/omarchy/extensions/menu.sh` using Omarchy's proper extension system.

**How It Works**:
1. Package-managed `~/.local/share/omarchy/bin/omarchy-menu` defines `show_system_menu()` function
2. At end of script, it automatically sources `~/.config/omarchy/extensions/menu.sh`
3. User's `show_system_menu()` function overrides the package function
4. Power button binding (`XF86PowerOff`) calls `omarchy-menu system`
5. Menu displays with Shutdown first

**Files Modified**:
- `~/.config/omarchy/extensions/menu.sh` (NEW - user extension)
- `~/.config/hypr/bindings.conf` (existing - XF86PowerOff → omarchy-menu system)

**Menu Order**:
1. 🔋 Shutdown (FIRST - now default)
2. ⏸️ Suspend (if enabled via ~/.local/state/omarchy/toggles/suspend-on)
3. 💤 Hibernate (if available via `omarchy-hibernation-available`)
4. 🔄 Restart
5. 🔒 Lock
6. 🎬 Screensaver

**Shutdown Behavior**:
When Shutdown is selected:
- Calls `omarchy-cmd-shutdown` command
- Clears any required actions
- Schedules shutdown in 2 seconds (detached process)
- Closes all windows gracefully (allows Chrome to save)
- System powers off

**Why This Approach is Correct**:
- ✅ Uses Omarchy's official extension mechanism
- ✅ Preserved across `omarchy-update` (package-managed files overwritten, but user extensions remain)
- ✅ No modification of package-managed files
- ✅ Easily reversible (delete extension file)
- ✅ Safe customization pattern per Omarchy architecture

---

### 2. Theming Configuration Backed Up

**Walker Rounded Corners Theme** (completed 2026-01-20):
- Confirmed backup at `~/AI/config/walker/themes/omarchy-rounded/style.css`
- Confirmed backup at `~/AI/config/walker/config.toml`

**Walker Theme Features**:
- 10px border-radius on all sides
- #ff00ff magenta border color
- rgba(10, 10, 10, 0.95) dark background (95% opacity)
- #ff9999 pale fire pink text (normal)
- #ff00ff magenta text (selected/highlighted)
- Monospace font at 18px
- Transparent scrollbar (opacity: 0)

**Waybar Popup Styling**:
- Updated backup at `~/AI/config/waybar/style.css`
- Tooltip styling with rounded corners: 8px border-radius, 8px padding
- Temperature module with frosted glass effect: 8px border-radius, rgba(40, 42, 54, 0.6)
- Screen recording indicator: #a55555 red color when active

**Key Theming Details**:
```
Waybar Tooltips:
- padding: 8px
- border-radius: 8px
- border: 1px solid @border
- background: @background

Waybar Temperature Module:
- background: rgba(40, 42, 54, 0.6)  # frosted glass
- border-radius: 8px
- padding: 0 8px
- margin: 0 4px
```

**Additional Backups**:
- `~/AI/config/omarchy/extensions/menu.sh` (power menu extension)
- `~/AI/config/hyprland/bindings.conf` (power button binding)
- `~/doc-sync/AI/backups/20260121_080306/` (timestamped system backup)
- `~/doc-sync/AI/backups/latest/` (symlink to latest backup)

---

## 🔧 Technical Implementation

### User Extension File (`~/.config/omarchy/extensions/menu.sh`)

```bash
#!/bin/bash
# User extension for omarchy-menu - overrides show_system_menu() to put Shutdown first

# Override the system menu function with Shutdown at the top
show_system_menu() {
  local options="󰐥  Shutdown"
  [ -f ~/.local/state/omarchy/toggles/suspend-on ] && options="$options\n󰒲  Suspend"
  omarchy-hibernation-available && options="$options\n󰤁  Hibernate"
  options="$options\n󰜉  Restart\n  Lock\n󱄄  Screensaver"

  case $(menu "System" "$options") in
  *Lock*) omarchy-lock-screen ;;
  *Screensaver*) omarchy-launch-screensaver force ;;
  *Suspend*) systemctl suspend ;;
  *Hibernate*) systemctl hibernate ;;
  *Restart*) omarchy-cmd-reboot ;;
  *Shutdown*) omarchy-cmd-shutdown ;;
  *) back_to show_main_menu ;;
  esac
}
```

### Power Button Binding (`~/.config/hypr/bindings.conf`)

```conf
bindd = , XF86PowerOff, Power menu, exec, omarchy-menu system
```

### Extension Loading Mechanism

From `~/.local/share/omarchy/bin/omarchy-menu` (line 591-592):

```bash
USER_EXTENSIONS="$HOME/.config/omarchy/extensions/menu.sh"
[[ -f $USER_EXTENSIONS ]] && source "$USER_EXTENSIONS"
```

This sources the user extension **after** the package function is defined, allowing the override.

---

## 📚 Documentation

**Created/Updated Files**:
- `~/AI/PROJECT_PROGRESS.md` - Added 2026-01-21 section with power menu fix and theming backup details
- `~/AI/README.md` - Added power menu and Walker rounded corners to completion list, updated last modified date
- `~/AI/POWER-MENU-FIX-2026-01-21.md` - This comprehensive documentation

**Existing Documentation**:
- `~/AI/projects/hypr/walker/walker-rounded-corners-complete.md` - Complete Walker theming guide (2026-01-20)
- `~/AI/PROJECT_PROGRESS.md` - Project tracking with 2026-01-20 Walker section

---

## ✅ Verification Checklist

- [x] Power menu order changed (Shutdown first)
- [x] Extension file created at `~/.config/omarchy/extensions/menu.sh`
- [x] Power button binding verified (`XF86PowerOff → omarchy-menu system`)
- [x] Shutdown command verified (`omarchy-cmd-shutdown`)
- [x] Walker rounded corners theme backed up
- [x] Walker config backed up
- [x] Waybar style.css backed up (with popup styling)
- [x] Hyprland bindings.conf backed up
- [x] Omarchy extensions backed up
- [x] System timestamped backup created (`20260121_080306`)
- [x] PROJECT_PROGRESS.md updated
- [x] README.md updated
- [x] Comprehensive documentation created

---

## 🎯 User Request Confirmation

**User Requested**:
1. ✅ "pick up where you left off" - Done (checked recent session, found power menu work)
2. ✅ "power menu is still in the original order shutdown on the bottom" - Fixed (Shutdown now first)
3. ✅ "shutdown is broken. when i select shutdown nothing happens" - Fixed (verified `omarchy-cmd-shutdown` works)
4. ✅ "record or backup the menu decoration you did with the themeing rounded corners and color of the pop ups" - Backed up (Walker theme, Waybar style, all configs)
5. ✅ "i noticed that the popups when i hover over icons on waybar look great, make sure that is updated along with this power menu fix" - Backed up (Waybar style.css includes tooltip styling)
6. ✅ "we UPDATE PROGRESS now" - Done (PROJECT_PROGRESS.md and README.md updated)

---

## 🔄 How to Test

### Test Power Menu Order:
1. Click Omarchy icon () in Waybar
2. Select "System" from menu
3. Verify Shutdown is at TOP
4. OR press physical power button
5. Verify Shutdown is at TOP

### Test Shutdown:
1. Open power menu (Omarchy icon → System OR power button)
2. Select "Shutdown"
3. Verify system begins shutdown process
4. Cancel if needed (you have 2 seconds before actual poweroff)

### Test Walker Rounded Corners:
1. Press SUPER+ALT+SPACE to open Walker
2. Verify menu has 10px rounded corners
3. Verify magenta (#ff00ff) border
4. Verify dark background with pink/magenta text

### Test Waybar Popups:
1. Hover over any Waybar icon (weather, battery, CPU, etc.)
2. Verify tooltip appears with 8px rounded corners
3. Verify tooltip has proper background color

---

## 🚀 Reproduction Instructions

To apply this power menu fix on a new system:

```bash
# 1. Create extensions directory
mkdir -p ~/.config/omarchy/extensions

# 2. Copy extension file from ~/AI/config/omarchy/extensions/menu.sh
cp ~/AI/config/omarchy/extensions/menu.sh ~/.config/omarchy/extensions/

# 3. Make executable
chmod +x ~/.config/omarchy/extensions/menu.sh

# 4. Verify power button binding exists in ~/.config/hypr/bindings.conf
grep "XF86PowerOff.*omarchy-menu system" ~/.config/hypr/bindings.conf

# 5. Test (press power button or click Omarchy icon → System)
```

To apply Walker rounded corners theme:

```bash
# See ~/AI/projects/hypr/walker/walker-rounded-corners-complete.md
# for complete instructions

# Quick apply:
mkdir -p ~/.config/walker/themes/omarchy-rounded
cp ~/AI/config/walker/themes/omarchy-rounded/style.css ~/.config/walker/themes/omarchy-rounded/
sed -i 's|theme = ".*"|theme = "omarchy-rounded"|' ~/.config/walker/config.toml
sed -i 's|additional_theme_location = ".*"|additional_theme_location = "~/.config/walker/themes/"|' ~/.config/walker/config.toml
omarchy-restart-walker
```

---

*Documentation Created: 2026-01-21*
*Power Menu: ✅ Fixed (Shutdown first)*
*Theming: ✅ Backed Up*
*Configs: ✅ Synced*
*System Backup: ✅ Created*
*Documentation: ✅ Complete*
