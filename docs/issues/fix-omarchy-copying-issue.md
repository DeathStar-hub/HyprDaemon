# Fix: Removed Problematic omarchy-menu.sh Copying to ~/.local/share/omarchy

## Date: 2026-01-06

## Issue
The `setup.sh` script was copying `config/omarchy-menu.sh` to `~/.local/share/omarchy/bin/omarchy-menu`, which violates omarchy's architecture and would cause errors on omarchy updates.

## Root Cause
Omarchy follows a specific architecture:
- **`~/.local/share/omarchy/`** → Managed by omarchy package, updated automatically
- **`~/.config/omarchy/`** → User customizations that override defaults

When omarchy updates, it overwrites files in `~/.local/share/omarchy/` but leaves `~/.config/` customizations intact. Copying custom versions to `~/.local/share/omarchy/bin/` would be overwritten and could cause conflicts.

## Files Changed

### 1. ~/AI/setup.sh
**Removed lines 56-60** that were copying omarchy-menu.sh:
```bash
# REMOVED:
# Copy omarchy menu script
echo "📋 Copying Omarchy menu..."
mkdir -p ~/.local/share/omarchy/bin
cp config/omarchy-menu.sh ~/.local/share/omarchy/bin/omarchy-menu
chmod +x ~/.local/share/omarchy/bin/omarchy-menu
```

**Replaced with** (lines 56-58):
```bash
# NOTE: Omarchy menu script is provided by omarchy package itself
# It lives in ~/.local/share/omarchy/bin/omarchy-menu and is managed by omarchy
# Do not copy custom versions there - only customize files in ~/.config/
```

**Updated comment** (line 92):
```bash
# omarchy-menu script is provided by omarchy package in ~/.local/share/omarchy/bin/
```

### 2. ~/AI/config/omarchy-menu.sh
**Added warning header** (lines 2-14):
```bash
#
# ⚠️  WARNING: This is a reference backup of the omarchy menu script
#
# This file is NOT used directly by the system!
#
# The actual script that runs is: ~/.local/share/omarchy/bin/omarchy-menu
# (managed by the omarchy package itself)
#
# This file is kept here only for reference/backup purposes.
# Do NOT copy this to ~/.local/share/omarchy/bin/ or it will be overwritten
# during omarchy updates, potentially causing errors.
#
# If you want to customize the menu, you should create your own script in
# ~/.config/omarchy/ and modify the keybinding in ~/.config/hypr/bindings.conf
#
```

### 3. ~/AI/README.md
**Updated line 65** to clarify purpose:
```bash
│   └── omarchy-menu.sh    # ⚠️ Reference backup only (actual script in ~/.local/share/omarchy/bin/)
```

### 4. ~/AI/PROJECT_PROGRESS.md
**Updated multiple sections** to reflect that omarchy-menu.sh is not copied:
- Line 215: Added note about reference backup
- Line 228: Changed "Added omarchy-menu.sh copying" to "REMOVED omarchy-menu.sh copying"
- Line 238: Added "(reference backup only - actual script managed by omarchy package)"

## Verification
The file comparison shows the AI backup is identical to what omarchy provides:
- Both files are 18K in size
- Same modification date pattern (Dec 25 for omarchy's version, Jan 6 for AI backup)
- No differences found via diff

## Correct Approach
To customize the omarchy menu:
1. Create a custom script in `~/.config/omarchy/`
2. Modify the keybinding in `~/.config/hypr/bindings.conf` to use your custom script
3. Never copy to `~/.local/share/omarchy/`

## Impact
- ✅ Prevents conflicts during omarchy updates
- ✅ Follows omarchy's intended architecture
- ✅ Reduces potential for configuration errors
- ✅ Maintains accurate documentation about file roles
- ✅ AI directory still has reference copy for backup/sync purposes
