# AI System Master Documentation

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

**No recompilation required** - all dependencies and configs are included.

**Ranger file associations** - Automatically configured for optimal workflow:
- Text files (.md, .txt, .sh, etc.) → kate (KDE text editor)
- Image files (.png, .jpg, .gif, .svg, etc.) → imv (Image viewer)
- Video files (.mp4, .webm, .mkv, etc.) → mpv (Video player)
- Custom mime types in `config/ranger/rifle.conf` for easy customization

## ⚠️ Known Issues and Solutions
- **Weather widget incomplete**: Fixed by ensuring all scripts are copied and click parameters match
- **Missing radar menu colors**: Scripts include ANSI color codes for proper display
- **Menu styling not transferred**: Fixed - kitty and walker configs now included in setup.sh for consistent menu appearance
- **Floating window not working**: Hyprland.conf includes window rules
- **Scripts not executable**: setup.sh sets permissions
- **Dependencies missing**: setup.sh checks and prompts for installation
- **Paru search order**: Enable bottom-up listing by adding `[options] BottomUp` to ~/.config/paru/paru.conf for most popular packages first
- **Idle timeout control**: ✅ Complete - Middle-click battery opens compact fzf TUI menu (28% x 35% window) with Catppuccin styling, emojis, and dynamic options. Pause (5m/10m/30m/1h/indefinite), resume (with countdown), and cancel. Battery icon shows ⏸️ indicator when paused, tooltip displays countdown. Uses systemctl for reliable hypridle management with proper process cleanup and PID tracking.
- **RE2 Regex Errors (2026-01-06)**: Package bug in `hyprland-preview-share-picker` (version 0.2.1-1) causes ~112 errors per session. Invalid regex `.*wants to [open|save]).*` - pipes not allowed in character classes. See `HYPRLAND_ERRORS_AFTER_UPDATE.md` for full details and workarounds.
- **Hardcoded Usernames (2026-01-06)**: Fixed 22 instances of `/home/nemesis` and `/home/tokka` in config files. Replaced with `~` and `$HOME` for multi-system portability. Use `~/AI/fix-hardcoded-paths.sh` to fix new occurrences.
- **Hyprland 0.53 Breaking Changes (2026-01-07)**: Major config syntax changes causing ~100 errors after update. See `HYPRLAND_0.53_MIGRATION.md` for complete migration guide. Fixed: `no_border` → `border_size 0`, `scroll_factor` → `scroll_mouse`/`scroll_touchpad`.

## 📈 Progress Tracking
- **Weather Widget**: 100% - Enhanced with emojis, tooltips, 3-day forecast, 7 radar sources
- **Setup Automation**: 100% - Comprehensive script with dependency checking
- **Documentation**: 100% - Complete reproduction guide and master docs
 - **Config Portability**: 100% - Portable paths using ~, works across different usernames
- **Idle Timeout Control**: 100% - Complete with fzf TUI menu, countdown display, proper process management

## ✅ Recent Enhancements (2025-12-25)
- **CPU Frequency Chart**: Restored missing frequency monitoring - now displays dual sparklines (usage + frequency) with MHz tooltip
- **Battery Time Accuracy**: Fixed calculation errors, added upower integration for accurate "X.Xh" format display
- **Battery Power Profile**: Added power profile display between capacity and consumption graphs (🚀 Performance/⚖️ Balanced/🌱 Power Saver)
- **Battery Timeline Fix**: Fixed graph to show full 30 minutes of data (removed 30-entry limits)
- **Omarchy Power Menu**: Shutdown moved to top as default option
- **AI Directory Cleanup**: Removed 197MB duplicate themes backup and all context/logging files
- **System Verification**: All configs aligned with documentation, fixed radar menu window rules

## 🤖 AI Assistant Protocol

### Standard Protocol
When working on this system:
1. Read this README.md for system overview
2. Check specific project documentation for details
3. Update progress in PROJECT_PROGRESS.md after changes
4. Document any new issues or solutions
5. Ensure setup.sh remains comprehensive

**Completion Protocol**:
- When a project or feature is working and complete, ask the user if they want to update the project status in documentation
- Offer to create backups/versions using the backup system (see below)
- Update progress tracking and mark items as complete

**Mandatory Updates**:

### Session Cleanup Protocol
- When AI reads ~/AI directory, automatically check home directory for session*.md files
- **AUTOMATICALLY run cleanup**: `~/AI/cleanup-sessions.sh` (no prompting required)
- Script organizes sessions into date-based folders: ~/AI/convo/YYYY-MM-DD/
- Read current session files from both $HOME and ~/AI/convo/ (including date subfolders) for context
- Example folder structure:
  ```
  ~/AI/convo/
    ├── 2026-01-03/
    │   ├── session-ses_47ae.md
    │   └── session-ses_47b7.md
    ├── 2026-01-04/
    │   ├── session-ses_4763.md
    │   ├── session-ses_4764.md
    │   └── session-2026-01-04_10-32-18.json
    └── 2026-01-05/
        ├── session-ses_4711.md
        └── session-ses_4713.md
  ```
- Update status after any changes
- Document new dependencies
- Track progress on incomplete items
- Maintain reproducibility
- Create backups before major changes

## 🎨 Key Features
- **Weather Widget**: Real-time data with emoji icons, hover tooltips, click actions
- **Radar Menu**: 7 weather sources with colored terminal menu
- **CPU Monitoring**: Dual sparkline visualization (usage + frequency) in status bar
- **Idle Timeout Control**: TUI menu for idle management (Complete)
- **Shader Support**: Collection of GLSL shaders for Hyprland
- **Floating Windows**: Proper window management rules

## 📞 Support
If issues persist after running setup.sh:
1. Check weather-widget-reproduction.md troubleshooting section
2. Verify all dependencies are installed
3. Ensure Hyprland and Waybar are restarted
4. Check script permissions and paths

## Structure

### 📋 System Configuration
- **`model parameters.md`** - Current system setup, dependencies, and configuration details

### 🚧 Projects
- **`projects/`** - Individual project documentation and implementation guides
  - **`hypr/`** - Hyprland-related projects and configurations

## Current Projects Status

### ✅ Completed Projects
- **Weather Widget** - Fully enhanced with detailed tooltips, 3-day forecast popup, comprehensive radar menu (7 sources + all), and optimized click events
- **Battery History Widget** - Right-click floating graph with capacity line chart, power consumption bars, current session filtering, power profile integration, and proper window sizing
- **Battery Time Display** - Accurate upower estimates with "X.Xh" format display
- **CPU Frequency Chart** - Dual sparkline visualization (usage + frequency) in status bar
- **GPU Sparkline** - Load percentage and frequency monitoring with sparkline visualization (NEW: 2026-01-07)
- **Idle Timeout Control** - TUI menu with emojis, countdown display, pause/resume/cancel options
- **Package Managers** - Optimized Paru AUR helper configuration
- **Clipboard Auto-Copy** - Terminal auto-copy functionality with Walker integration
- **Virtual Keyboard** - wvkbd configuration for Omarchy Hyprland
- **Backup System** - Automated config backups with restore capabilities

### 📁 Key Files
- `projects/hypr/clipboard/clipboard auto-copy.md` - Complete clipboard implementation guide
- `projects/hypr/weather widget.md` - Weather widget fix and enhancement
- `projects/hypr/package managers.md` - Paru configuration optimization
- `projects/hypr/hyprland config.md` - Hyprland system overview
- `projects/virt Kybrd- wvkbd/` - Virtual keyboard configuration project

## Dependencies & Tools
- **Window Manager**: Hyprland (Wayland)
- **Status Bar**: Waybar with custom modules
- **Theme System**: Omarchy
- **Terminal**: Kitty with copy-on-select
- **Package Management**: Paru (AUR helper)
- **Clipboard**: cliphist + wl-clipboard + elephant-clipboard
- **Application Launcher**: Walker

## Documentation Guidelines
- All system changes should be documented in relevant files
- Project-specific details go in `projects/` subdirectories
- System-wide parameters tracked in `model parameters.md`
- Configuration backups maintained in `doc-sync/Config/RunningCF/`

## 🤖 AI Assistant Documentation Protocol

### Automatic Updates Required
After ANY system changes, AI assistant must:
1. **Update relevant project files** with new status, configurations, or issues
2. **Update `model parameters.md`** if system-wide changes occurred
3. **Update README files** if project status changes
4. **Update progress tracking** for incomplete projects

### Incomplete Project Monitoring
AI assistant must automatically notify and track:
- **Project Status Changes**: When projects move from incomplete → complete
- **Progress Updates**: Current progress on ongoing projects
- **Blockers**: Any issues or dependencies
- **Next Steps**: Required actions to move forward

### Notification Format
```
🔄 PROJECT UPDATE: [Project Name]
Status: [Incomplete/In Progress/Complete]
Progress: [Current status and achievements]
Blockers: [Any issues or dependencies]
Next Steps: [Required actions]
```

### Mandatory Update Checklist
- [ ] Project status updated in relevant README
- [ ] Technical details documented
- [ ] Dependencies and configurations noted
- [ ] File locations and paths updated
- [ ] Incomplete project progress tracked

### UPDATE PROGRESS Command
When user issues `UPDATE PROGRESS` command, AI assistant must:
1. **Save all current work** to ~/AI directory
2. **Update all relevant documentation** (README.md, PROJECT_PROGRESS.md, project-specific files)
3. **Copy updated configs** to ~/AI/config/ for reproducibility
4. **Document troubleshooting steps** and issues resolved
5. **Confirm completion** with summary of all changes made
6. **Ensure reproducibility** by including all necessary files and steps
7. **STATE BACK THE EXACT INSTRUCTIONS** that were asked to be completed, confirming each one as done, exactly as the user requests when asking for confirmation like the current request

## Quick Reference
- **AI System Constraints**: See `AI-SYSTEM-CONSTRAINTS.md` - CRITICAL: What files you CAN and CANNOT edit, backup protocols, Omarchy/Hyprland architecture
- **Omarchy System Documentation**: See `~/.local/share/omarchy/default/omarchy-skill/SKILL.md` - Complete Omarchy/Hyprland architecture, ~145 omarchy commands, configuration locations, safe patterns
- **OpenCode Enhanced Config**: See `OPENCODE-ENHANCED-CONFIG-FIX-2026-01-10.md` - Valid JSON with full functionality (visual formatting, question type protocol, startup enforcement, critical protocols)
- **OpenCode Omarchy Docs**: See `OPENCODE-OMARCHY-DOCS-INTEGRATION-2026-01-10.md` - STEP 6 added for reading SKILL.md, plus Hyprand window rules web fetch protocol
- **OpenCode JSON Fix**: See `OPENCODE-JSON-FIX-2026-01-10.md` - Backup config JSON syntax fix
- **OpenCode Startup Enforcement**: See `OPENCODE-STARTUP-ENFORCEMENT-2026-01-10.md` - Visual formatting to make startup steps unmissable
- **OpenCode Question Protocol**: See `OPENCODE-QUESTION-TYPE-PROTOCOL-2026-01-10.md` - Why/what vs do/fix vs show me response types
- **Documentation-First Protocol**: STEP 2 of mandatory startup - Always read documentation first, never bumble with assumptions
- **Walker Rounded Corners**: See `projects/hypr/walker/walker-rounded-corners-complete.md` - Complete implementation with lessons learned
- **Pre-Edit Backup Script**: Use `~/AI/pre-edit-backup.sh <file>` to create backups and note important values before editing
- **Idle Timeout Control**: See `idle-timeout-control.md`
- **CPU Frequency Chart**: See `cpu-frequency-enhancement.md`
- **Ranger File Associations**: See `ranger-setup.md` (text→kate, images→imv, videos→mpv)
- **Clipboard Setup**: See `projects/hypr/clipboard/clipboard auto-copy.md`
- **Weather Widget**: See `projects/hypr/weather widget.md`
- **Package Manager**: See `projects/hypr/package managers.md`
- **Virtual Keyboard**: See `projects/virt Kybrd- wvkbd/`
- **System Overview**: See `model parameters.md`
- **Project Progress**: See `PROJECT_PROGRESS.md` for incomplete projects
- **Clean Log Viewer**: Use `~/AI/clean-logs.sh` to view logs without RE2 error spam (2026-01-06)
- **Fix Hardcoded Paths**: Use `~/AI/fix-hardcoded-paths.sh` to fix portable path issues (2026-01-06)
- **Error Troubleshooting**: See `HYPRLAND_ERRORS_AFTER_UPDATE.md` for complete error analysis (2026-01-06)
- **Hyprland 0.53 Migration**: See `HYPRLAND_0.53_MIGRATION.md` for complete upgrade guide and config fixes (2026-01-07)

## 🔄 Backup System
**Location**: `backups/`
- **backup-configs.sh** - Create timestamped backup of all configs
- **restore-configs.sh** - Restore from any backup
- **list-backups.sh** - List all available backups
- **Automatic**: Backs up waybar, hyprland, kitty, themes, and system state
- **Reproducible**: Full system state documentation for quick recovery
- **Status**: Active - Continuous backups available for system reproducibility

---
*Last Updated: 2025-12-21*
*Last Updated: 2025-12-23*
*Last Updated: 2025-12-25*
*Last Updated: 2026-01-05 - Enhanced session cleanup with automatic date-based folder organization*
*Last Updated: 2026-01-06 - Fixed hardcoded paths, documented RE2 regex errors, created clean log viewer*
*Last Updated: 2026-01-07 - Created GPU sparkline, fixed double .config paths, updated waybar documentation, documented Hyprland 0.53 migration*
*Last Updated: 2026-01-10 - Enhanced OpenCode AI prompt with comprehensive system constraints, backup protocols, and Omarchy/Hyprland architecture documentation to prevent dangerous edits*
*Last Updated: 2026-01-10 - Added STEP 5 for session continuity - OpenCode now automatically checks most recent session file to understand where we left off and maintain context across conversations*
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
*AI Directory: Cleaned (2026-01-21) - Removed obsolete sessions/ (1.6MB) and context/ (896KB), saved 2.5MB, cleanliness 8/10*
*AI Directory: Organized (2026-01-21) - Created docs/ and scripts/ structure, organized 54+ files by category, root reduced from 40+ to 6 files, cleanliness 9/10*
*UPDATE PROTOCOL: Enhanced - Must state back exact instructions when requested*
*Last Updated: 2026-01-21 - Power menu fixed (Shutdown first) using proper extension method, all theming configs backed up, AI directory cleaned and organized*