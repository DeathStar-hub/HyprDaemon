# 🤖 AI Instance Instructions

## ⚠️ MANDATORY FIRST STEP (Do This IMMEDIATELY)
```bash
~/AI/cleanup-sessions.sh
```
This automatically moves all session*.md files from $HOME to ~/AI/convo/YYYY-MM-DD/
**NO PROMPTING REQUIRED** - Run this BEFORE doing anything else when starting in ~/AI.

## Multi-System Synchronization

**IMPORTANT:** This ~/AI directory is synced across multiple computers with different usernames via Syncthing. When installing or updating configs, you MUST adapt paths to match the current system's username.

### Username Handling Rules

1. **Always use `~/.config/` for paths to user config files** (not `/home/username/`)
2. **Hyprland bindings**: Use `--directory=~` or `--directory=$HOME` for kitty terminal
3. **Waybar exec paths**: Use `~/.config/waybar/scripts/` (not absolute paths)
4. **Script references**: Use `~/.config/waybar/scripts/` when calling other scripts
5. **Do not hardcode usernames** like `/home/nemesis/`, `/home/tokka/`, etc.

### Setup Script Handles Username Replacement

The `setup.sh` script automatically replaces hardcoded username paths in configs. However, when manually editing files or when AI makes changes, always use portable paths.

## When Starting in ~/AI Directory

**Run this command immediately:**

```bash
cat PROJECT_PROGRESS.md
```

This will provide:
1. Current system status and completed projects
2. List of all enhancements and fixes
3. Overview of system configuration
4. Documentation for each major feature

**AUTOMATIC SESSION CLEANUP (MANDATORY):**

1. **Run cleanup script automatically:**
    ```bash
    ~/AI/cleanup-sessions.sh
    ```
    - Moves all session*.md files from $HOME to ~/AI/convo/YYYY-MM-DD/
    - Creates date-based folders for organized storage
    - No prompting required - runs automatically

2. **Read all session files for full context:**
    - Check $HOME for any remaining session*.md files
    - Read ALL session*.md files from ~/AI/convo/ (recursively includes all date subfolders)
    - Example: `find ~/AI/convo -name "session*.md" -type f | sort`
    - **CRITICAL**: Must read ALL session files from ALL date subfolders including:
      - `~/AI/convo/2026-01-03/`
      - `~/AI/convo/2026-01-04/`
      - `~/AI/convo/2026-01-05/`
      - `~/AI/convo/2026-01-06/`
      - `~/AI/convo/2026-01-07/`
      - And any other date folders
    - This provides complete conversation history and recent work context from ALL sessions

## SETUP ON NEW COMPUTER

**If user indicates this is a NEW setup or FRESH install:**

1. **Run setup script to reproduce all configurations:**
    ```bash
    cd ~/AI
    ./setup.sh
    ```

2. **After setup completes, restart services:**
    ```bash
    hyprctl reload
    pkill waybar && waybar &
    ```

3. **Verify everything is working:**
    - Check waybar modules are displaying correctly
    - Test popup menus (weather left-click, battery right-click, etc.)
    - Verify keyboard shortcuts work
    - Confirm rounded corners on windows

**Setup script will:**
- ✅ Copy all waybar configs and scripts
- ✅ Copy all hyprland configurations (11 files)
- ✅ Copy kitty terminal configuration
- ✅ Copy ranger file associations
- ✅ Set up battery logging service
- ✅ Fix any hardcoded username paths
- ✅ Make all scripts executable
- ✅ Check for missing dependencies

**IMPORTANT: Only run setup.sh on fresh systems!**
Running setup.sh will OVERWRITE existing configurations. Never run this on a system that already has customizations you want to keep.

## Quick Context Commands

To get system context:
- `cat PROJECT_PROGRESS.md` - Check project status
- `cat README.md` - System overview
- `ls -la config/` - See backed up configs

## Session Export

To export the current opencode conversation:
- `~/AI/export_current_session.sh` - Export current session to ~/AI/sessions/YYYY-MM-DD/
- `~/AI/context/start_and_export.sh` - Start session with auto-export on exit

See `SESSION_EXPORT_GUIDE.md` for full session management details.

## Example AI Session Start

```bash
# AI Instance starts
cd ~/AI
cat PROJECT_PROGRESS.md

# Output shows:
# 🔄 Incomplete Projects
# ✅ Completed Projects with dates
# 🤖 AI Assistant Protocol
# 📅 Recent Enhancements

# AI now has full system context
```

## Current System Status (as of 2026-01-07)

- **Weather Widget**: ✅ Complete with 7 radar sources, enhanced tooltips
- **Battery History Widget**: ✅ Complete with floating graphs, power profile integration
- **Battery Time Display**: ✅ Complete with upower "X.Xh" format
- **CPU Frequency Chart**: ✅ Complete with dual sparkline (usage + frequency)
- **GPU Sparkline**: ✅ Complete with load monitoring, frequency display, 📊 icon (NEW!)
- **Idle Timeout Control**: ✅ Complete with TUI menu, emojis, countdown
- **Omarchy Power Menu**: ✅ Shutdown at top as default
- **Hyprland Window Rules**: ✅ All floating windows configured with 10px rounded corners
- **Backup System**: ✅ Active with full restoration
- **Setup Script**: ✅ Comprehensive with all customizations (includes GPU script)
- **Complete Reproducibility**: ✅ 100% - All configs synced and ready for deployment

## Conversation Continuity Phrases

Use these to maintain context:
- "Based on PROJECT_PROGRESS.md, we completed..."
- "I see that system has been fully verified..."
- "Let me check the current status from documentation..."
- "According to the README, system includes..."
- "Checking YES-REPRODUCIBLE-2026-01-07.md for complete setup status..."

## Setup Instructions for Users

**For NEW COMPUTER (fresh setup):**
Tell the AI:
> "This is a new computer, please read ~/AI and run all setup scripts"

The AI will then:
1. Read PROJECT_PROGRESS.md for context
2. Run `~/AI/cleanup-sessions.sh` automatically
3. Read all session files for full context
4. Execute `./setup.sh` to reproduce all configurations
5. Restart services (hyprland, waybar)
6. Verify everything is working

**For EXISTING SYSTEM (updates only):**
Tell the AI:
> "I want to update [specific feature] based on ~/AI configs"

The AI will then:
1. Read relevant documentation
2. Update only the requested feature
3. Verify changes work
4. Update documentation

---

*Always read PROJECT_PROGRESS.md first when starting in ~/AI directory for full system context.*
