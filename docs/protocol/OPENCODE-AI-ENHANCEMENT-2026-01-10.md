# OpenCode AI Prompt Enhancement - 2026-01-10

## Summary
Enhanced OpenCode configuration with comprehensive system constraints, backup protocols, and Omarchy/Hyprland architecture documentation to prevent AI from making dangerous edits to package-managed files.

---

## Changes Made

### 1. Created `~/AI/AI-SYSTEM-CONSTRAINTS.md`
A comprehensive guide for AI assistants covering:

**Critical File Editing Rules:**
- ✅ SAFE TO EDIT: `~/.config/waybar/`, `~/.config/hypr/`, `~/.config/kitty/`, `~/.config/omarchy/`, `~/.config/walker/`
- 🚫 NEVER EDIT: `~/.local/share/omarchy/` (package-managed, overwritten on updates), `~/.local/share/`, `~/.local/state/`, `~/.cache/`, `/usr/`

**Omarchy Architecture Explained:**
- `~/.local/share/omarchy/` = Package-managed (READ ONLY)
- `~/.config/omarchy/` = User customizations (EDITABLE)
- How updates work and why editing `.local/` breaks things

**Hyprland Architecture:**
- Sourcing pattern from omarchy defaults
- How to override configs in `~/.config/hypr/`

**Mandatory Backup Protocol:**
1. Create timestamped backup before editing
2. Note important values (fonts, colors, paths, numbers)
3. Run backup system

**Portable Path Rules:**
- Always use `~/.config/` or `$HOME/.config/`
- Never use hardcoded `/home/username/`

**External Documentation Links:**
- Omarchy: https://github.com/omarchy-linux/omarchy
- Hyprland: https://wiki.hyprland.org/
- Waybar: https://github.com/Alexays/Waybar/wiki

---

### 2. Updated `~/.config/opencode/opencode.json`
Replaced the basic prompt with comprehensive instructions:

**Mandatory Startup Steps (in order):**
1. Run `~/AI/cleanup-sessions.sh` (NO PROMPTING)
2. Read `~/AI/AI-SYSTEM-CONSTRAINTS.md` (CRITICAL)
3. Read `~/AI/README.md`
4. Read all `.md` files in `~/AI/` and `~/AI/convo/`

**Critical Rules Added:**
- Explicit list of SAFE directories to edit
- Explicit list of FORBIDDEN directories (with reasons)
- Backup protocol before any config edit
- Portable path rules with examples

**Protocols Added:**
- 'UPDATE PROGRESS' command details
- Documentation update requirement
- Backup system usage

---

### 3. Updated `~/AI/config/opencode/opencode.json`
Same changes as above for reproducibility/sync purposes.

---

### 4. Created `~/AI/pre-edit-backup.sh`
Helper script for AI assistants to use before editing files:

**Features:**
- Creates timestamped backup: `file.ext.backup-20260110_143022`
- Warns if editing files in `~/.local/` (package-managed)
- Extracts and displays important values:
  - Fonts
  - Color codes (hex)
  - Numeric settings (heights, widths, timeouts)
  - File paths
- User confirmation for dangerous edits

**Usage:**
```bash
~/AI/pre-edit-backup.sh ~/.config/waybar/config.jsonc
```

---

### 5. Updated `~/AI/README.md`
Added new entries to Quick Reference:
- **AI System Constraints**: Reference to `AI-SYSTEM-CONSTRAINTS.md`
- **Pre-Edit Backup Script**: Reference to `pre-edit-backup.sh`

---

## Benefits

### Prevents Dangerous Mistakes
- AI now knows NEVER to edit `~/.local/share/omarchy/` (breaks on omarchy updates)
- AI knows to create backups before editing
- AI knows to note original values (fonts, colors, paths)

### Clear Architecture Understanding
- AI understands how Omarchy and Hyprland are structured
- AI knows the difference between package-managed and user customization files
- AI has links to official documentation

### Portable Paths
- AI will use `~/.config/` instead of `/home/nemesis/`
- Configs will work across different systems with different usernames
- No more hardcoded path issues

### Reproducibility
- All configs backed up before changes
- Documentation updated after changes
- System state tracked

---

## Testing Recommendations

To verify the new setup works:

1. **Start a new OpenCode session** - verify it:
   - Automatically runs `~/AI/cleanup-sessions.sh`
   - Reads `~/AI/AI-SYSTEM-CONSTRAINTS.md`
   - Doesn't prompt for confirmation

2. **Test backup helper:**
   ```bash
   ~/AI/pre-edit-backup.sh ~/.config/waybar/config.jsonc
   ```
   - Should create backup
   - Should show important values
   - Should warn if file is in `~/.local/`

3. **Test editing workflow:**
   - Ask AI to edit a config file
   - Verify it creates backup first
   - Verify it notes original values
   - Verify it uses portable paths

---

## Files Changed

### Created:
- `~/AI/AI-SYSTEM-CONSTRAINTS.md`
- `~/AI/pre-edit-backup.sh`

### Modified:
- `~/.config/opencode/opencode.json`
- `~/AI/config/opencode/opencode.json`
- `~/AI/README.md`

### Referenced (no changes):
- `~/AI/cleanup-sessions.sh`
- `~/doc-sync/AI/backups/backup-configs.sh`

---

## Next Steps

1. Test the new OpenCode configuration
2. Verify AI follows the constraints
3. Test the `pre-edit-backup.sh` script
4. Update documentation if issues found
5. Consider adding more constraints if needed

---

**Status**: ✅ Complete
**Date**: 2026-01-10
**Impact**: All future AI sessions will have comprehensive constraints and backup protocols
