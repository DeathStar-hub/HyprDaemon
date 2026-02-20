# Pre-Edit Safety Checklist

## ⚠️ BEFORE EDITING ANY CRITICAL FILE

### Step 1: Backup
- [ ] Run `~/AI/backup-critical-configs.sh`
- [ ] Verify backup was created in `~/.config/backups/`

### Step 2: Validate (for JSON files)
- [ ] For `.json` files: `cat file.json | python3 -m json.tool > /dev/null`
- [ ] If invalid, DO NOT SAVE - fix syntax first

### Step 3: Test After Edit
- [ ] Save file
- [ ] Validate again (for JSON)
- [ ] Test the application can read the file
- [ ] If it breaks, restore from backup immediately

---

## 🚨 CRITICAL FILES - ALWAYS BACKUP FIRST

| File | Why Critical | Backup Command |
|------|--------------|----------------|
| `~/.config/opencode/opencode.json` | Breaks AI if invalid JSON | `~/AI/backup-critical-configs.sh` |
| `~/.config/hypr/hyprland.conf` | Breaks window manager | `~/AI/backup-critical-configs.sh` |
| `~/.config/waybar/config.jsonc` | Breaks status bar | `~/AI/backup-critical-configs.sh` |
| `~/.config/hypr/bindings.conf` | Breaks keybindings | `~/AI/backup-critical-configs.sh` |

---

## 🛠️ Emergency Recovery

If you grenade a config file:

```bash
# List available backups
ls -la ~/.config/backups/

# Restore from latest backup
cp ~/.config/backups/FILENAME.backup-TIMESTAMP ~/.config/path/to/original

# For opencode specifically
cp ~/.config/backups/opencode.json.backup-TIMESTAMP ~/.config/opencode/opencode.json
```

---

**REMEMBER:** Better to spend 30 seconds on backup than 30 minutes fixing a broken system!
