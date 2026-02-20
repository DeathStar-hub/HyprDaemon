# Hyprland 0.53 Breaking Changes - Migration Guide

**Date**: 2026-01-07
**Last Updated**: 2026-01-06

---

## 🚨 Overview

Hyprland version 0.53 introduced **major breaking changes** to configuration syntax. If you're upgrading from Hyprland 0.52 or earlier, your system will have **~100+ config errors** after the update.

This document covers all breaking changes encountered and their fixes.

---

## 📋 Breaking Changes & Fixes

### 1. `no_border` Window Rule Removed

**Status**: ✅ Fixed
**Error Count**: ~98 errors

#### The Issue

Old syntax for removing borders from windows:
```conf
# OLD (Broken)
windowrule = no_border on, class:jetbrains
windowrule = no_border on, class:pip
```

Hyprland 0.53 removed the `no_border` option entirely.

#### The Fix

Replace with `border_size 0`:
```conf
# NEW (Fixed)
windowrule = border_size 0, class:jetbrains
windowrule = border_size 0, class:pip
```

#### Files Affected

These files needed updating:
- `~/.local/share/omarchy/default/hypr/apps/jetbrains.conf` (lines 5, 13)
- `~/.local/share/omarchy/default/hypr/apps/pip.conf` (line 7)
- Any other window rules using `no_border on`

---

### 2. `scroll_factor` Renamed

**Status**: ✅ Fixed
**Error Count**: 2 errors

#### The Issue

Old syntax for scroll sensitivity in window rules:
```conf
# OLD (Broken)
windowrule = scroll_factor 1.5, class:firefox
windowrule = scroll_factor 2.0, class:chromium
```

Hyprland 0.53 renamed `scroll_factor` to device-specific options.

#### The Fix

Use `scroll_mouse` or `scroll_touchpad`:
```conf
# NEW (Fixed)
windowrule = scroll_mouse 1.5, class:firefox
windowrule = scroll_mouse 2.0, class:chromium

# For touchpad:
windowrule = scroll_touchpad 1.5, class:firefox
```

#### Files Affected

- `~/.config/hypr/input.conf` (lines 35-36)
- Any custom window rules using `scroll_factor`

---

## 🔧 Complete Fix Procedure

### Step 1: Identify Affected Files

After upgrading to Hyprland 0.53, check for errors:
```bash
hyprctl configerrors
```

You should see ~100+ errors for `no_border` and `scroll_factor`.

### Step 2: Create Backups

**Before making any changes**, backup your configs:
```bash
# Backup Omarchy app configs
cp ~/.local/share/omarchy/default/hypr/apps/jetbrains.conf ~/.local/share/omarchy/default/hypr/apps/jetbrains.conf.backup-$(date +%Y%m%d)
cp ~/.local/share/omarchy/default/hypr/apps/pip.conf ~/.local/share/omarchy/default/hypr/apps/pip.conf.backup-$(date +%Y%m%d)

# Backup input config
cp ~/.config/hypr/input.conf ~/.config/hypr/input.conf.backup-$(date +%Y%m%d)
```

### Step 3: Apply Fixes

#### Fix `no_border` errors:

```bash
# In jetbrains.conf
sed -i 's/no_border on/border_size 0/g' ~/.local/share/omarchy/default/hypr/apps/jetbrains.conf

# In pip.conf
sed -i 's/no_border on/border_size 0/g' ~/.local/share/omarchy/default/hypr/apps/pip.conf

# Any other affected files
grep -r "no_border on" ~/.local/share/omarchy/default/hypr/ 2>/dev/null
```

#### Fix `scroll_factor` errors:

```bash
# In input.conf
sed -i 's/scroll_factor/scroll_mouse/g' ~/.config/hypr/input.conf
```

### Step 4: Reload Hyprland

Apply all changes:
```bash
hyprctl reload
```

### Step 5: Verify

Check that errors are resolved:
```bash
hyprctl configerrors
```

**Expected output**: `Config errors: 0`

---

## 📊 Error Summary

| Error Type | Old Syntax | New Syntax | Count | Status |
|------------|-------------|-------------|--------|--------|
| Border removal | `no_border on` | `border_size 0` | ~98 | ✅ Fixed |
| Scroll sensitivity | `scroll_factor` | `scroll_mouse` / `scroll_touchpad` | 2 | ✅ Fixed |
| **Total** | | | ~100 | ✅ **Fixed** |

---

## 🔄 Future Upgrades

### To Avoid These Issues in Future:

1. **Check Hyprland changelog** before updating:
   ```bash
   paru -Si hyprland
   ```

2. **Keep configs in `~/AI/config/`** for easy updates

3. **Test on one system first** before syncing to others

### What About Omarchy Updates?

The `~/.local/share/omarchy/` directory is **managed by the Omarchy package**. When Omarchy updates to support Hyprland 0.53:

- Configs will be updated automatically by the package
- Manual fixes will be overwritten by package updates
- **However**: Your current fixes will work until Omarchy updates

---

## 🔗 Related Documentation

- `HYPRLAND_ERRORS_AFTER_UPDATE.md` - Complete error analysis
- `ERROR_SUMMARY.md` - Summary of all issues fixed on 2026-01-06
- `fix-hardcoded-paths.sh` - Script for fixing portable paths

---

## ✅ Verification Checklist

After upgrading to Hyprland 0.53:

- [ ] Ran `hyprctl configerrors` to check for issues
- [ ] Created backups of all affected files
- [ ] Fixed all `no_border on` → `border_size 0` instances
- [ ] Fixed all `scroll_factor` → `scroll_mouse` instances
- [ ] Ran `hyprctl reload` to apply changes
- [ ] Verified `hyprctl configerrors` returns 0 errors
- [ ] Tested that windows still work correctly
- [ ] Documented any custom window rules affected

---

## 🆘 Troubleshooting

### Still seeing errors after fixes?

1. **Check for other deprecated options**:
   ```bash
   hyprctl configerrors | grep "invalid field type"
   ```

2. **Check Hyprland version**:
   ```bash
   hyprctl version
   ```

3. **Check for package updates**:
   ```bash
   paru -Syu hyprland
   ```

### Omarchy configs keep reverting?

Omarchy package updates may overwrite your fixes. Solutions:
1. Wait for Omarchy update with 0.53 support
2. Keep your fixed configs in `~/AI/config/omarchy/` and reapply after updates

---

**Status**: All breaking changes documented and fixes tested
**System Health**: ✅ Fully functional after migration
**Reproducibility**: Configs synced to `~/AI/config/` for future installations

---

*Last Updated: 2026-01-06*
*Hyprland Version: 0.53+*
*Status: Migration Complete*
