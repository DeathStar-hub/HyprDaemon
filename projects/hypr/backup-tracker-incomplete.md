# Session-Based Backup Tracker

**Status:** INCOMPLETE - Not auto-incrementing on new sessions
**Created:** 2026-02-20
**Priority:** Medium

## What It Does
- Tracks OpenCode sessions since last backup
- Shows count in waybar (💾 N)
- Prompts to backup after 5 sessions

## Files Created (need to be in AI folder for transfer)

### ~/AI/projects/hypr/backup-tracker/
```
backup-tracker.sh       # Core tracking script
backup-now.sh          # Manual backup + reset  
waybar-backup-status.sh # Waybar module
setup.sh               # Installation script
```

### Files Modified (need manual config or script)
- ~/.config/hypr/autostart.conf - Added exec-once lines
- ~/.config/waybar/config.jsonc - Added backup-status module
- ~/.config/opencode/opencode.json - Added Step 1b to protocol
- ~/AI/cleanup-sessions.sh - Added --record call

### Backup Destination
- Primary: ~/doc-sync/AI/backups/ (timestamped folders)
- Script: ~/AI.Bacl/backups/backup-configs.sh

## Issue
The backup tracker does NOT auto-increment on new sessions reliably.

## To Do
- [ ] Fix auto-increment on new conversation start
- [ ] Add all files to AI folder for reproducibility
- [ ] Document setup process for new Omarchy builds
