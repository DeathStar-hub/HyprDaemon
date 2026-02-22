# Computer Group
# Contains: Hardware, configs, system, Hyprland, Waybar, Omarchy

---

## Session: ses_384f (2026-02-20)

**Date:** 2026-02-20
**Topic:** Backup tracker, waybar session counter, fixed backup status display

### Key Points
- Session counter tracking OpenCode sessions since last backup
- Fixed waybar backup-status module showing wrong output
- Session tracker autostart working (count = 1)
- Waybar shows "💾 1" with tooltip showing sessions since backup
- Tested backup-tracker.sh --record and --status
- Waybar restarted to apply changes

### Files Changed
- ~/.config/backups/waybar-backup-status.sh - fixed output format

---

## Session: ses_3a31 (2026-02-14)

**Date:** 2026-02-14
**Topic:** Conversation Summarization & Topic Grouping System Design

### Key Points
- Major project to organize AI conversation history for efficient context
- Three-tier system: Groups → 1-page summaries → Full conversations (.md.gz)
- 99% context reduction at startup (100 bytes vs 500KB)
- 10 groups created: ai, work, computer, network, development, media, productivity, personal, general, archive
- Generalized groups better than technical topics for cross-topic queries
- Each conversation belongs to 1-5 groups

### Files Changed
- PROJECT_PROGRESS.md updated
- ~/AI/convo/groups/ created with 10 group files

---

## Session: ses_3a30 (2026-02-14)

**Date:** 2026-02-14
**Topic:** Local AI models not working - hardware, power, or model size issue

### Key Points
- User's local models not working despite dedicated driver running
- Possible causes: hardware issue, lack of power, model too large
- Investigation into local model setup (Ollama, etc.)


---

## Session: ses_3c6c (2026-02-14)

**Date:** 2026-02-14
**Topic:** Fish shell jl command fix - migrated from broken autojump to zoxide

### Key Points
- Fixed broken `jl` command (jump + ls) due to autojump Python module error
- Migrated to zoxide (modern Rust replacement for autojump)
- Imported 20 directories from autojump history
- Updated `~/.config/fish/functions/jl.fish` to use `z` instead of `j`
- Updated `~/.config/fish/config.fish` to replace autojump with zoxide

### Files Changed
- `~/.config/fish/functions/jl.fish`
- `~/.config/fish/config.fish`

### Commands Used
```bash
zoxide import --from autojump --merge ~/.local/share/autojump/autojump.txt
```


---

## Session: ses_39d9 (2026-02-15)

**Date:** 2026-02-15
**Topic:** Lock screen persists after running SleepN function

### Key Points
- User's SleepN function (disables idle/lock) not working properly
- Lock screen still appearing after running SleepN
- Discussed hypridle, hyprlock, and DPMS settings
- Fixed SleepN.fish function to kill hyprlock and ensure DPMS on

### Files Changed
- `~/.config/fish/functions/SleepN.fish`

---

## Session: ses_39dd (2026-02-14)

**Date:** 2026-02-14
**Topic:** Hyprland config errors after omarchy update

### Key Points
- User ran omarchy update and got hyprctl configerrors
- Troubleshooting Hyprland configuration issues
- Fixed config errors related to window rules and syntax

---

## Session: ses_4606 (2026-01-08)

**Date:** 2026-01-08
**Topic:** Waybar GPU detection and weather widget fixes

### Key Points
- Fixed GPU monitoring script for Intel/AMD cards
- Weather widget configuration updates
- Waybar restart and configuration sync

