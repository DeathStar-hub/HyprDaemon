# Development Group
# Contains: Coding, tools, repos, programming

---

## Session: ses_3a31 (2026-02-14)

**Date:** 2026-02-14
**Topic:** Conversation Summarization & Topic Grouping System Design

### Key Points
- Major project to organize AI conversation history for efficient context
- Three-tier system: Groups → 1-page summaries → Full conversations (.md.gz)
- 99% context reduction at startup (100 bytes vs 500KB)
- 10 groups created: ai, work, computer, network, development, media, productivity, personal, general, archive

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
- Investigation into local model setup


---

## Session: ses_3c6c (2026-02-14)

**Date:** 2026-02-14
**Topic:** Fish shell jl command fix - migrated from broken autojump to zoxide

### Key Points
- Fixed broken `jl` command (jump + ls)
- Migrated from autojump to zoxide (Rust-based, faster)
- Imported 20 directories from autojump history
- Updated `~/.config/fish/functions/jl.fish` and `~/.config/fish/config.fish`

### Commands Used
```bash
zoxide import --from autojump --merge ~/.local/share/autojump/autojump.txt
```

---

## Session: ses_3c6b (2026-02-14)

**Date:** 2026-02-14
**Topic:** Hyprland update errors and session list display

### Key Points
- Brief session showing Hyprland update errors near line 27-33
- Autojump traceback error shown
- User navigating session history with opencode

