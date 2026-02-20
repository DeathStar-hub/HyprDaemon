# Hyprland Error Troubleshooting Guide

## 📊 Current Issues After Omarchy Update (2026-01-06)

### Issue 1: RE2 Regex Errors (~110+ per session)

**Status**: Package bug in `hyprland-preview-share-picker`

**Error Message**:
```
E0000 00:00:1767704607.344507 re2.cc:926] Invalid RE2: unexpected ): ^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save]).*|[C|c]hoose.*)
```

**Root Cause**:
- The regex pattern `.*wants to [open|save]).*` is invalid
- Pipes (`|`) are NOT allowed inside character classes `[...]` in RE2
- This is a bug in the package itself, not your config

**Affected Files**:
- Installed: `/home/nemesis/.config/hyprland-preview-share-picker/config.yaml`
- Pattern is compiled into the binary (not in config file)

**Workaround Options**:
1. **Uninstall the package** (if you don't need it):
   ```bash
   sudo pacman -R hyprland-preview-share-picker
   ```

2. **Report the bug** to package maintainer:
   - Check AUR or GitHub repo for `hyprland-preview-share-picker`
   - Report the regex bug: `[open|save]` should be `(open|save)`

3. **Wait for fix** and update package

**Impact**: High error count but system works fine (cosmetic noise in logs)

---

### Issue 2: Hardcoded Usernames (22 instances)

**Status**: Breaks multi-system portability

**Problem**:
- Config files have hardcoded paths like `/home/nemesis` and `/home/tokka`
- Syncthing syncs configs to different usernames
- Scripts break on other systems

**Files with Hardcoded Paths**:

#### Hyprland Bindings (`~/.config/hypr/bindings.conf`)
```bash
# Current (BROKEN):
bindd = SUPER, RETURN, Terminal, exec, kitty --directory=/home/nemesis fish
bindd = SUPER SHIFT, O, Opencode, exec, $terminal --dir="/home/tokka/Work/Ai/Projects" -e "opencode"
bindd = SUPER SHIFT, U, OpenCode, exec, $terminal --dir="/home/tokka/Work/Ai/Projects" -e "gemini"

# Fix:
bindd = SUPER, RETURN, Terminal, exec, kitty --directory=~ fish
bindd = SUPER SHIFT, O, Opencode, exec, $terminal --dir="$HOME/Work/Ai/Projects" -e "opencode"
bindd = SUPER SHIFT, U, OpenCode, exec, $terminal --dir="$HOME/Work/Ai/Projects" -e "gemini"
```

#### Waybar Scripts (`~/.config/waybar/config.jsonc`)
```json
// Current (BROKEN):
"on-click": "/home/nemesis/.config/waybar/scripts/waybar-toggle.sh"
"exec": "/home/nemesis/.config/waybar/scripts/cpu-spark.sh"
"exec": "/home/nemesis/.config/waybar/scripts/weather.sh"
"on-click": "/home/nemesis/.config/waybar/scripts/weather.sh left"
"on-click-middle": "/home/nemesis/.config/waybar/scripts/weather.sh middle"
"on-click-right": "/home/nemesis/.config/waybar/scripts/weather.sh right"
"exec": "/home/nemesis/.config/waybar/scripts/custom-battery.sh"
"on-click-middle": "/home/nemesis/.config/waybar/scripts/sleep-interrupt-menu.sh"

// Fix:
"on-click": "~/.config/waybar/scripts/waybar-toggle.sh"
"exec": "~/.config/waybar/scripts/cpu-spark.sh"
"exec": "~/.config/waybar/scripts/weather.sh"
// (etc for all script paths)
```

#### Waybar Scripts (`~/.config/waybar/scripts/`)
```bash
# Current (BROKEN):
idle_status=$(/home/nemesis/.config/waybar/scripts/idle-controller.sh status)
...
/home/nemesis/AI/config/waybar/scripts/idle-controller.sh pause-5

# Fix:
idle_status=$HOME/.config/waybar/scripts/idle-controller.sh status
...
$HOME/AI/config/waybar/scripts/idle-controller.sh pause-5
```

#### Hyprland Autostart (`~/.config/hypr/autostart.conf`)
```bash
# Current (BROKEN - commented out):
# exec-once = pkill waybar; uwsm-app -- waybar -c /home/nemesis/.config/waybar/config.jsonc

# Fix:
exec-once = pkill waybar; uwsm-app -- waybar -c ~/.config/waybar/config.jsonc
```

---

## 🔧 Fix Procedures

### Option 1: Manual Fix (Quick)

Run this to fix all hardcoded paths:
```bash
# Fix Hyprland bindings
sed -i 's|/home/nemesis|$HOME|g' ~/.config/hypr/bindings.conf
sed -i 's|/home/tokka|$HOME|g' ~/.config/hypr/bindings.conf

# Fix Waybar config
sed -i 's|/home/nemesis/|~/.config/|g' ~/.config/waybar/config.jsonc

# Fix Waybar scripts
sed -i 's|/home/nemesis/|~/.config/|g' ~/.config/waybar/scripts/*.sh
sed -i 's|/home/nemesis/AI/config/|$HOME/AI/config/|g' ~/.config/waybar/scripts/*.sh

# Fix Hyprland autostart
sed -i 's|/home/nemesis/|~/.config/|g' ~/.config/hypr/autostart.conf

# Reload Hyprland to apply changes
hyprctl reload
```

### Option 2: Automated Fix Script

Use the provided `fix-hardcoded-paths.sh` script to update all files.

### Option 3: Update AI/setup.sh

Update `~/AI/setup.sh` to automatically replace hardcoded paths during installation.

---

## 📋 Verification Checklist

After fixes, verify:
- [ ] No `/home/nemesis` or `/home/tokka` in active config files (except backups)
- [ ] Scripts work on both systems
- [ ] Syncthing syncs configs without breaking functionality
- [ ] RE2 errors either eliminated or acknowledged as package bug

---

## 🎯 Portability Rules

When creating new configs, always follow these rules:

1. **Home directory**: Use `~` or `$HOME`
   - ❌ `/home/nemesis/.config/waybar/config.jsonc`
   - ✅ `~/.config/waybar/config.jsonc`
   - ✅ `$HOME/.config/waybar/config.jsonc`

2. **Script paths**: Use relative paths from config directory
   - ❌ `/home/nemesis/.config/waybar/scripts/script.sh`
   - ✅ `~/.config/waybar/scripts/script.sh`

3. **User-specific directories**: Use `$HOME` or `$USER`
   - ❌ `/home/tokka/Work/Ai/Projects`
   - ✅ `$HOME/Work/Ai/Projects`
   - ✅ `~/$USER/Work/Ai/Projects`

4. **AI directory**: Always use `~/AI/` or `$HOME/AI/`
   - ❌ `/home/nemesis/AI/config/`
   - ✅ `~/AI/config/`

---

## 📞 Support Resources

- **Omarchy Documentation**: Check Omarchy theme system docs
- **Hyprland Wiki**: https://wiki.hyprland.org/
- **AUR Package**: Report hyprland-preview-share-picker bug on AUR

---

*Last Updated: 2026-01-06*
*Status: Active Issues Identified*
