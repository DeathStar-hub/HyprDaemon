# AI System Master Documentation

## 🚀 INSTANCE STARTUP PROTOCOL (DO FIRST!)

### 🐢 QUALITY OVER SPEED PRINCIPLE

**ALWAYS REMEMBER:** The user wants it done **RIGHT**, not fast.

- ❌ **Wrong:** Skip steps to answer in 3 seconds → Get it wrong → Waste 10 minutes fixing
- ✅ **Right:** Take 60 seconds to load context → Answer correctly → Done in 1 minute

**Take the extra minute to be thorough. Every. Single. Time.**

---

**At the start of EVERY new session, run:**
```bash
~/AI/startup-protocol.sh
```

**Then check:**
- [ ] `~/AI/STARTUP_CHECKLIST.md` - Quick reference checklist
- [ ] Load relevant skills (e.g., `skill Omarchy` for Hyprland tasks)
- [ ] Read recent conversation history for continuity

---

## ⚠️ MANDATORY FIRST STEPS

### STEP 1: Run Cleanup Script
**When starting in ~/AI directory, ALWAYS run:**
```bash
~/AI/cleanup-sessions.sh
```
This automatically moves all session*.md files from $HOME to ~/AI/convo/YYYY-MM-DD/
**NO PROMPTING REQUIRED** - Do this automatically before any other work.

---

### 🚨 STEP 2: READ DOCUMENTATION FIRST - NO ASSUMPTIONS! 🚨

**CRITICAL RULE FOR ANY PROJECT WORK:**

📚 **IF STARTING OR WORKING ON ANY PROJECT/FEATURE:**
- ✅ **ALWAYS search for and read relevant documentation FIRST**
- ❌ **NEVER bumble along with assumptions**
- 📖 **Check for existing documentation** in ~/AI/projects/, ~/AI/, and official sources
- 🔍 **Search online for official docs** (GitHub, GitBook, wiki, etc.)
- ⚠️ **If you don't know how something works, READ BEFORE ACTING**

**WHAT HAPPENS WHEN YOU SKIP DOCUMENTATION:**
- ❌ Multiple failed attempts (like Walker theming took 10+ tries)
- ❌ Wrong approaches based on incorrect assumptions
- ❌ Time wasted on trial-and-error instead of following proven methods
- ❌ User frustration from repeated mistakes

**DOCUMENTATION SEARCH PROTOCOL:**

1. **Search ~/AI for existing docs:**
   ```bash
   find ~/AI -name "*[project-name]*.md" -o -name "*[component]*.md"
   ```

2. **Search ~/projects for relevant project:**
   ```bash
   ls ~/AI/projects/[category]/
   # Check for existing project documentation
   ```

3. **Search online for official documentation:**
   - GitHub repositories (look for README, wiki, docs/)
   - Official websites (look for documentation, wiki, guides)
   - GitBook / Notion documentation sites
   - Arch Wiki / other distro wikis

4. **EXAMPLE - Should Have Done This First (Walker Theming):**
   - ❌ **WRONG**: "I'll just try CSS variables and see if they work"
   - ✅ **RIGHT**: "Let me search Walker documentation first"
     - Check: https://github.com/abenz1267/walker
     - Check: https://benz.gitbook.io/walker/customization/theme
     - Check: Examine default theme at `resources/themes/default/style.css`
     - **Result**: Would have learned that Walker doesn't inherit CSS variables properly

**BEFORE YOU MAKE ANY CHANGES:**
- [ ] Searched ~/AI for existing documentation?
- [ ] Searched ~/AI/projects/ for project-specific docs?
- [ ] Searched official GitHub/GitBook for component documentation?
- [ ] Read and understood the documentation?
- [ ] Identified the correct approach from official sources?

**IF DOCUMENTATION IS UNCLEAR:**
- 📖 Re-read more carefully
- 🔍 Search for examples in documentation
- 💬 Look for troubleshooting sections or FAQs
- 🐛 Check GitHub issues for similar problems

---

## 🎯 Project Goals
- Create a fully reproducible, turnkey Hyprland desktop environment configuration
- Implement enhanced Waybar with weather widget featuring 7 radar sources, colored menus, and complete functionality
- Provide seamless config synchronization between computers without manual setup or recompilation
- Maintain comprehensive documentation for any AI assistant to understand and maintain the system

## 📊 Current Status
**Status**: Complete and Reproducible
- ✅ Weather widget with full functionality (tooltips, popups, radar menu)
- ✅ CPU sparkline with frequency chart in Waybar (dual usage + frequency monitoring)
- ✅ GPU sparkline with load percentage and frequency (NEW: 2026-01-07)
- ✅ Idle timeout control TUI menu (middle-click battery) - Complete
- ✅ Hyprland floating window rules
- ✅ Shader collection for visual effects
- ✅ Automated setup script with dependency checking
- ✅ Transfer and sync instructions

## 🔧 System Requirements
**Operating System**: Arch Linux
**Window Manager**: Hyprland (Wayland)
**Status Bar**: Waybar
**Terminal**: Kitty
**Browser**: Brave
**Theme System**: Omarchy

**Required Packages**:
- curl, jq, brave-browser, kitty, waybar, hyprland, omarchy
- Fonts: ttf-fira-code, ttf-nerd-fonts-symbols-mono (or equivalent)

**API Requirements**:
- Open-Meteo API (free, no key required)
- Location: Whitecourt, AB (54.15°N, -115.68°W)

## 🚀 Quick Setup (Turnkey)

### Complete System Setup
1. Copy folder: `cp -r /path/to/AI ~/AI`
2. Run setup: `cd ~/AI && ./setup.sh`
3. Restart: `hyprctl reload && pkill waybar && waybar`

### Waybar Only Setup
```bash
cd ~/AI
./setup-waybar.sh
```

## 📁 Folder Structure
```
~/AI/
  ├── README.md              # This master documentation
  ├── setup.sh               # Automated installation script
  ├── setup-waybar.sh        # Waybar customizations setup script
  ├── weather-widget-reproduction.md  # Detailed reproduction guide
  ├── cpu-frequency-enhancement.md   # CPU frequency chart implementation
  ├── idle-timeout-control.md         # Idle timeout TUI menu implementation
  ├── ranger-setup.md            # Ranger file associations (text→kate, images→imv)
  ├── waybar-complete-guide.md  # Complete waybar documentation
  ├── waybar-fixes-2026-01-07.md  # Waybar fixes documentation
  ├── HYPRLAND_0.53_MIGRATION.md # Hyprland 0.53 upgrade guide (2026-01-07)
  └── PROJECT_STATUS.md         # Current project status
├── config/
│   ├── waybar/            # Waybar configs and custom scripts
│   │   ├── config.jsonc   # Main Waybar configuration
│   │   ├── style.css      # Styling
│   │   └── scripts/       # Weather, battery, CPU, idle scripts
│   ├── hyprland/          # Custom Hyprland configs (looknfeel, window rules)
│   ├── ranger/            # Ranger file associations (text→kate, images→imv, video→mpv)
│   ├── opencode/           # OpenCode auto-start config
│   └── omarchy-menu.sh    # ⚠️ Reference backup only (actual script in ~/.local/share/omarchy/bin/)
└── projects/              # Project documentation
```

## 🔄 Sync and Update Process

### Multi-System Setup (Syncthing)
**This ~/AI directory is designed to be synced across multiple computers** with different usernames via Syncthing.

**Portable Path Rules** (all configs follow these):
- Always use `~/.config/` for config file paths (never `/home/username/`)
- Use `--directory=~` for kitty terminal directory (Hyprland bindings)
- Use `~/.config/waybar/scripts/` for script references
- Never hardcode usernames like `/home/nemesis/`, `/home/tokka/`, etc.

**Setup script handles username adaptation**:
- Automatically replaces any remaining hardcoded paths with current user's home
- Ensures configs work on any system with different username
- Copies custom ranger configuration for proper file opening (text→kate, images→imv, video→mpv)

**To sync updates between computers**:
1. Make changes on source computer
2. Syncthing automatically syncs ~/AI directory
3. On target computer, run: `cd ~/AI && ./setup.sh`
4. Restart services: `hyprctl reload && pkill waybar && waybar`

### Google Drive Sync

**Goal**: Sync AI directory to Google Drive for Perplexity web portal access.

**Setup**: See `~/AI/docs/recent/GOOGLE-DRIVE-SYNC-SIMPLIFIED-2026-02-02.md`

**Quick Start**:
```bash
# Install rclone first
sudo pacman -S rclone

# Then configure Google Drive OAuth
rclone config create gdrive

# Then sync
~/AI/sync-to-google-drive.sh
```

**Google Drive Access**: drive.google.com → Google Drive/AI/

**Direct Sync**: Simple rclone script syncs `~/AI/` directly to Google Drive
- No Perplexity workspace needed
- No Dropbox sync needed

---
*Last Updated: 2025-12-21*
*Last Updated: 2025-12-23*
*Last Updated: 2025-12-25*
*Last Updated: 2026-01-05 - Enhanced session cleanup with automatic date-based folder organization*
*Last Updated: 2026-01-06 - Fixed hardcoded paths, documented RE2 regex errors, created clean log viewer*
*Last Updated: 2026-01-07 - Created GPU sparkline, fixed double .config paths, updated waybar documentation, documented Hyprland 0.53 migration*
*Last Updated: 2026-01-10 - Enhanced OpenCode AI prompt with comprehensive system constraints, backup protocols, and Omarchy/Hyprland architecture documentation to prevent dangerous edits*
*Last Updated: 2026-01-10 - Added STEP 5 for session continuity - OpenCode now automatically checks most recent session file to understand where we left off and maintain context across conversations*
*Last Updated: 2025-12-23 (System Verification Session)**Last Updated: 2026-02-02 (Google Drive Direct Sync - Simple rclone script for ~/AI/ directory, Perplexity workspace removed)*
*Last Updated: 2026-01-10 - Enhanced OpenCode startup enforcement with visual emphasis (emojis, all caps, borders) to make mandatory steps truly unmissable and prevent AI from skipping protocol*
*Last Updated: 2026-01-10 - Fixed OpenCode backup config JSON syntax - removed extra closing braces from ~/AI/config/opencode/opencode.json*
*Last Updated: 2026-01-10 - Fixed OpenCode Enhanced Config JSON Syntax - Recreated enhanced config with proper JSON escaping (valid JSON) while preserving full functionality (visual formatting, question type protocol, startup enforcement, critical protocols)*
*AI Protocol: Active - Auto-updates required after all changes*
*Backup System: Active - Continuous config backups available*
*Weather Widget: Complete - Advanced features with 7 radar sources, floating menu, detailed reproduction guide*
*Battery Widget: Complete - Floating graph with optimized layout, power profile integration, current session filtering, and perfect timeline display*
*Idle Timeout Control: Complete - Compact styled fzf TUI menu with Catppuccin theme, emojis, countdown display, proper process management, reliable hypridle control*
*Session Management: Enhanced - Automatic cleanup with date-based folder organization (YYYY-MM-DD)*
*Path Portability: Complete - All hardcoded usernames replaced with ~/\$HOME, multi-system ready*
*Error Analysis: Complete - RE2 regex errors documented, clean log viewer created, Hyprland 0.53 migration guide created*
*Waybar: Complete - All custom modules working (CPU, GPU, weather, battery), full documentation*
*Hyprland Migration: Complete - Breaking changes documented and fixes tested for version 0.53*
*Walker Rounded Corners: Complete (2026-01-20) - 10px border-radius, magenta borders, explicit hex values, full documentation*
*Power Menu: Fixed (2026-01-21) - Shutdown now first option using proper Omarchy extension method, configs backed up*
*Power Menu Wrapper: Fixed (2026-02-02) - Power button menu click handling fixed via wrapper script that sets PATH, DISPLAY, and WAYLAND_DISPLAY environment variables when invoked via keybinding. Root cause: Commands executed via Hyprland keybindings run in minimal execution context without full environment variable inheritance. Previously attempted fixes (dimaround toggle, Walker theme import) addressed symptoms, not the underlying environment issue.*
*AI Directory: Cleaned (2026-01-21) - Removed obsolete sessions/ (1.6MB) and context/ (896KB), saved 2.5MB, cleanliness 8/10*
*AI Directory: Organized (2026-01-21) - Created docs/ and scripts/ structure, organized 54+ files by category, root reduced from 40+ to 6 files, cleanliness 9/10*
*UPDATE PROTOCOL: Enhanced - Must state back exact instructions when requested*
*Last Updated: 2026-02-02 - AI Dropbox sync setup (Perplexity integration), power menu wrapper fix (environment variable solution), AI directory cleanup (post-sync recovery), all configs backed up, system fully reproducible*