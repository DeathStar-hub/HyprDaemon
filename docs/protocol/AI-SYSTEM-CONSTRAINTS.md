# AI System Constraints & Architecture

**Last Updated**: 2026-01-10
**Purpose**: Critical constraints for AI assistants working on this system

---

## 🚨 CRITICAL FILE EDITING RULES

### 📁 READ ONLY - NEVER MODIFY THESE DIRECTORIES:

**NEVER edit files in these locations - they are package-managed:**
- `~/.local/share/omarchy/` - Managed by omarchy package, overwritten on updates
- `~/.local/share/` - Package-managed data
- `~/.local/state/` - Application state files
- `~/.cache/` - Cache files
- `/usr/` - System files (package manager territory)

### ✅ SAFE TO EDIT - ONLY THESE DIRECTORIES:

**ONLY edit files in these locations - user customizations:**
- `~/.config/waybar/` - Waybar configuration and scripts
- `~/.config/hypr/` - Hyprland configuration
- `~/.config/kitty/` - Kitty terminal config
- `~/.config/omarchy/` - Omarchy user customizations (overrides defaults)
- `~/.config/walker/` - Walker launcher config
- `~/.config/ghostty/` - Ghostty terminal config (if used)
- `~/.config/mako/` - Mako notifications config

---

## 🔒 BEFORE EDITING ANY CONFIG FILE:

### MANDATORY BACKUP PROTOCOL:

**Step 1: Create timestamped backup of the file:**
```bash
cp ~/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc.backup-$(date +%Y%m%d_%H%M%S)
```

**Step 2: Note important values before changing:**
- Font names and sizes
- Color hex codes
- File paths
- Numeric values (heights, widths, timeouts)
- Keybindings

**Step 3: Document the original state:**
```json
// Original: font-family: "Fira Code"; size: 12
// Changed to: font-family: "JetBrains Mono"; size: 14
```

**Step 4: Run the backup system:**
```bash
~/doc-sync/AI/backups/backup-configs.sh
```

---

## 🏗️ OMARCHY ARCHITECTURE (CRITICAL TO UNDERSTAND)

### Directory Structure:
```
~/.local/share/omarchy/    ← PACKAGE MANAGED (READ ONLY)
├── bin/                    ← Omarchy scripts (auto-updated)
├── default/                ← Default configs (auto-updated)
└── themes/                 ← Theme files (auto-updated)

~/.config/omarchy/          ← USER CUSTOMIZATIONS (EDITABLE)
└── current/                ← Current theme overrides
```

### How Omarchy Works:
1. **Defaults** are in `~/.local/share/omarchy/default/`
2. **User overrides** go in `~/.config/omarchy/`
3. Omarchy loads defaults first, then applies user overrides
4. On omarchy updates, `~/.local/share/omarchy/` is overwritten
5. `~/.config/omarchy/` is preserved (your customizations)

### Rule: **NEVER edit `~/.local/share/omarchy/`**
- It will be overwritten on the next omarchy update
- Your changes will be lost
- Could cause conflicts during updates

### Correct approach for customizations:
```bash
# ❌ WRONG - Will be overwritten
cp my-custom-menu.sh ~/.local/share/omarchy/bin/omarchy-menu

# ✅ RIGHT - User customization
cp my-custom-menu.sh ~/.config/omarchy/custom-menu.sh
# Then update ~/.config/hypr/bindings.conf to use it
```

---

## 🪟 HYPRLAND ARCHITECTURE

### Configuration Structure:
```
~/.config/hypr/
├── hyprland.conf           ← Main config (sourced from omarchy defaults)
├── autostart.conf          ← Autostart applications
├── bindings.conf           ← Keybindings
├── looknfeel.conf          ← Appearance settings
└── windows.conf            ← Window rules
```

### Sourcing Pattern (from hyprland.conf):
```conf
# These are from omarchy package (READ ONLY)
source = ~/.local/share/omarchy/default/hypr/autostart.conf
source = ~/.local/share/omarchy/default/hypr/bindings/*.conf
source = ~/.local/share/omarchy/default/hypr/looknfeel.conf
source = ~/.local/share/omarchy/default/hypr/input.conf
source = ~/.local/share/omarchy/default/hypr/windows.conf

# These are your customizations (EDITABLE)
# You can override defaults by redefining them in ~/.config/hypr/*.conf
```

### Rule: **Edit `~/.config/hypr/*.conf` to override defaults**
- Don't edit `~/.local/share/omarchy/default/hypr/`
- Redefine settings in `~/.config/hypr/` to override
- Later definitions take precedence

---

## 📝 PORTABLE PATH RULES

### Always use these formats:
```bash
~/.config/waybar/scripts/    ← Portable (works on any system)
$HOME/.config/waybar/scripts/  ← Portable (works on any system)

❌ NEVER use hardcoded paths:
/home/nemesis/.config/waybar/scripts/    ← Only works on nemesis user
/home/tokka/.config/waybar/scripts/     ← Only works on tokka user
```

### For Hyprland bindings:
```conf
# ❌ WRONG
exec-once = kitty --directory /home/nemesis

# ✅ RIGHT
exec-once = kitty --directory=~
```

---

## 🔄 BACKUP SYSTEM

### Location: `~/doc-sync/AI/backups/`

### Scripts:
- `backup-configs.sh` - Create timestamped backup
- `restore-configs.sh <TIMESTAMP>` - Restore from backup
- `list-backups.sh` - List all backups
- `latest/` - Symlink to most recent backup

### What gets backed up:
- Waybar configs and scripts
- Hyprland configs
- Kitty config
- Omarchy theme (`~/.config/omarchy/current`)
- System state snapshot

### Always run backup before major changes:
```bash
~/doc-sync/AI/backups/backup-configs.sh
```

---

## 📋 EDITING CHECKLIST

Before editing any config file, ensure:

- [ ] File is in `~/.config/` (not `~/.local/`)
- [ ] Timestamped backup created
- [ ] Original values noted (fonts, colors, paths, numbers)
- [ ] Backup system run (`~/doc-sync/AI/backups/backup-configs.sh`)
- [ ] Using portable paths (`~` instead of `/home/username/`)
- [ ] Documentation updated after changes

---

## 🚫 COMMON MISTAKES TO AVOID

### ❌ Editing Package Files
```bash
# DON'T DO THIS
nano ~/.local/share/omarchy/default/hypr/looknfeel.conf
```

### ✅ Correct Approach
```bash
# DO THIS INSTEAD
nano ~/.config/hypr/looknfeel.conf
# Redefine settings you want to change
```

---

### ❌ Hardcoding Usernames
```bash
# DON'T DO THIS
cp /home/nemesis/.config/waybar/config.jsonc /backup/
```

### ✅ Correct Approach
```bash
# DO THIS INSTEAD
cp ~/.config/waybar/config.jsonc ~/backup/
```

---

### ❌ Forgetting Backups
```bash
# DON'T DO THIS
nano ~/.config/waybar/config.jsonc  # No backup!
```

### ✅ Correct Approach
```bash
# DO THIS INSTEAD
cp ~/.config/waybar/config.jsonc ~/.config/waybar/config.jsonc.backup-$(date +%Y%m%d)
nano ~/.config/waybar/config.jsonc
```

---

## 🔗 EXTERNAL DOCUMENTATION

### Omarchy Documentation:
- GitHub: https://github.com/omarchy-linux/omarchy
- Wiki: https://github.com/omarchy-linux/omarchy/wiki
- Release notes include architecture changes

### Hyprland Documentation:
- Official: https://wiki.hyprland.org/
- Configuration: https://wiki.hyprland.org/Configuring/
- Window rules: https://wiki.hyprland.org/Configuring/Window-Rules/

### Waybar Documentation:
- Official: https://github.com/Alexays/Waybar/wiki
- Custom modules: https://github.com/Alexays/Waybar/wiki/Configuration
- IPC (for scripts): https://github.com/Alexays/Waybar/wiki/IPC

---

## 🚨 WARNING SIGNS

**If you're about to:**
- Edit anything in `~/.local/share/`
- Use `/home/nemesis/` or `/home/tokka/` paths
- Edit files without backing up
- Copy scripts to `/usr/bin/` or `/usr/local/bin/`

**STOP AND RECONSIDER - These will break things!**

---

## ✅ SUCCESS PATTERN

The correct workflow for system changes:

1. Identify what needs to change
2. Verify file is in `~/.config/` (editable)
3. Create timestamped backup
4. Note original values
5. Run backup system
6. Make changes with portable paths
7. Test changes
8. Update documentation
9. Copy updated configs to `~/AI/config/` for reproducibility

---

**Remember:**
- `~/.config/` = Your customizations (EDIT)
- `~/.local/` = Package managed (READ ONLY)
- Always backup before editing
- Always use portable paths
- Always document changes
