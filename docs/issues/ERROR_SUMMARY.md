# Hyprland Errors - Complete Fix Summary

**Date**: 2026-01-06
**User Request**: Fixed 500,000 errors after Omarchy update, now at ~79 errors remaining

---

## 📊 Error Analysis Results

### Total Errors Found: **129**

1. **RE2 Regex Errors**: 112 errors
   - **Source**: `hyprland-preview-share-picker` package (installed 2026-01-01)
   - **Issue**: Invalid regex syntax in package binary
   - **Impact**: High error count, but system works fine
   - **Status**: Package bug - needs upstream fix

2. **Aquamarine/DRM Errors**: 17 errors
   - **Source**: Hyprland/Aquamarine runtime
   - **Issues**:
     - `drm: getCurrentCRTC: No CRTC 0` (6x)
     - `drm: Cannot commit when a page-flip is awaiting` (3x)
     - `drm: Skipping device...not a KMS device` (1x)
   - **Impact**: Harmless - normal for Intel graphics + multi-monitor setup

---

## ✅ Fixed Issues

### Hardcoded Usernames (22 instances) - **RESOLVED** ✓

**Problem**: Configs had `/home/nemesis` and `/home/tokka` hardcoded, breaking multi-system sync.

**Files Fixed**:
1. `~/.config/hypr/bindings.conf` - Hyprland keybindings
2. `~/.config/hypr/autostart.conf` - Autostart scripts
3. `~/.config/waybar/config.jsonc` - Waybar main config
4. `~/.config/waybar/scripts/*.sh` - All waybar scripts

**Replacements Made**:
- `/home/nemesis/` → `~/.config/`
- `/home/nemesis` → `~`
- `/home/tokka/` → `$HOME/`
- `/home/tokka` → `$HOME`

**Verification**: ✓ No hardcoded paths in active configs

**Tools Created**:
- `~/AI/fix-hardcoded-paths.sh` - Automated fix script for future use
- `~/AI/HYPRLAND_ERRORS_AFTER_UPDATE.md` - Complete troubleshooting guide

---

## 🔧 RE2 Regex Error Details

### The Bug

**Invalid Pattern**:
```regex
.*wants to [open|save]).*
```

**Problem**: Pipes `|` are NOT allowed inside character classes `[...]` in RE2 regex engine

**Correct Pattern**:
```regex
.*wants to (open|save)).*
```

### Error Messages
```
E0000 00:00:1767704607.344507 re2.cc:926] Invalid RE2: unexpected ): ^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save]).*|[C|c]hoose.*)
```

### Workarounds

**Option 1: Unshare Package** (Recommended if not needed)
```bash
sudo pacman -R hyprland-preview-share-picker
```

**Option 2: Report Bug**
- Check AUR for `hyprland-preview-share-picker`
- Report regex bug: `[open|save]` should be `(open|save)`

**Option 3: Ignore Errors**
- System works fine despite errors
- Just log noise

---

## 📋 Verification Checklist

- [x] Identified all error sources
- [x] Fixed hardcoded username paths (22 instances)
- [x] Created automated fix script
- [x] Updated documentation
- [x] Created troubleshooting guide
- [ ] Uninstall hyprland-preview-share-picker (optional)
- [ ] Report RE2 bug to upstream (optional)

---

## 🎯 Portability Rules (For Future Reference)

When creating new configs, ALWAYS use:

1. **Home directory**: Use `~` or `$HOME`
   - ❌ `/home/nemesis/.config/waybar/config.jsonc`
   - ✅ `~/.config/waybar/config.jsonc`

2. **Script paths**: Use relative paths from config directory
   - ❌ `/home/nemesis/.config/waybar/scripts/script.sh`
   - ✅ `~/.config/waybar/scripts/script.sh`

3. **User-specific directories**: Use `$HOME` or `$USER`
   - ❌ `/home/tokka/Work/Ai/Projects`
   - ✅ `$HOME/Work/Ai/Projects`

4. **AI directory**: Always use `~/AI/` or `$HOME/AI/`
   - ❌ `/home/nemesis/AI/config/`
   - ✅ `~/AI/config/`

---

## 📞 Quick Commands

### To Apply Config Changes:
```bash
hyprctl reload
pkill waybar && waybar
```

### To Fix New Hardcoded Paths:
```bash
~/AI/fix-hardcoded-paths.sh
```

### To Check Current Errors:
```bash
# RE2 errors (package bug)
journalctl --user --since "today" --no-pager | grep "Invalid RE2" | wc -l

# Aquamarine errors (normal DRM issues)
cat /run/user/1000/hypr/*/hyprland.log 2>/dev/null | grep -i "ERR" | wc -l
```

### To Verify No Hardcoded Paths:
```bash
grep -r "/home/nemesis\|/home/tokka" ~/.config/hypr ~/.config/waybar ~/.config/walker ~/.config/kitty 2>/dev/null | grep -v "\.backup\|\.log"
```

---

## 📁 Files Created/Modified

**Created**:
- `~/AI/HYPRLAND_ERRORS_AFTER_UPDATE.md` - Comprehensive troubleshooting guide
- `~/AI/fix-hardcoded-paths.sh` - Automated path fixer script
- `~/AI/ERROR_SUMMARY.md` - This document

**Modified**:
- `~/AI/README.md` - Added error documentation

**Fixed**:
- `~/.config/hypr/bindings.conf`
- `~/.config/hypr/autostart.conf`
- `~/.config/waybar/config.jsonc`
- `~/.config/waybar/scripts/*.sh`

---

## 🔄 Next Steps

### Immediate (Optional):
1. **Unshare problematic package**:
   ```bash
   sudo pacman -R hyprland-preview-share-picker
   ```
   This will eliminate 112 RE2 errors immediately.

2. **Reload configs**:
   ```bash
   hyprctl reload
   pkill waybar && waybar
   ```

### Long-term:
1. **Report RE2 bug** to package maintainer
2. **Monitor** for package updates with fix
3. **Always use** portable paths (`~`, `$HOME`) in new configs

---

**Status**: Issues identified, documented, and partially resolved ✓
**Remaining Errors**: ~112 RE2 errors (package bug, harmless)
**System Health**: ✅ Fully functional

---

*Generated: 2026-01-06*
*AI Session: ses_4710cd9b0ffeLMBzn65yswKoPl*
