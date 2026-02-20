# OpenCode Omarchy Documentation Integration - 2026-01-10

## Summary

Enhanced OpenCode configuration to include mandatory reading of Omarchy SKILL.md documentation for complete system architecture understanding, plus added instruction to fetch current Hyprland window rules documentation when needed.

---

## Problem

**Issue:** AI assistant had no access to Omarchy system documentation and Hyprland window rules documentation.

**User Observation:**
- "I didn't see it read any documentation on omarchy or hyprland"
- Asked: "Can we direct it to a webpage to read or is there some local documentation on system?"

**Discovery:**
- **Excellent local documentation exists:** `~/.local/share/omarchy/default/omarchy-skill/SKILL.md` (370 lines)
- Contains comprehensive Omarchy/Hyprland architecture
- Not currently in mandatory reading steps

---

## Solution

### What's in SKILL.md

The `~/.local/share/omarchy/default/omarchy-skill/SKILL.md` file contains:

**System Architecture:**
- Complete Omarchy/Hyprland architecture overview
- Configuration locations for all components:
  - Hyprland (window rules, animations, keybindings, monitors, etc.)
  - Waybar (status bar)
  - Walker (app launcher)
  - Terminals (alacritty, kitty, ghostty)
  - Mako (notifications)
  - SwayOSD (on-screen display)

**~145 Omarchy Commands:**
- `omarchy-refresh-*` - Reset config to defaults
- `omarchy-restart-*` - Restart a service/app
- `omarchy-toggle-*` - Toggle features
- `omarchy-theme-*` - Theme management
- `omarchy-install-*` - Install optional software
- `omarchy-launch-*` - Launch apps
- `omarchy-cmd-*` - System commands
- `omarchy-pkg-*` - Package management
- `omarchy-setup-*` - Initial setup tasks
- `omarchy-update-*` - System updates

**Configuration Documentation:**
- Hyprland config structure and file purposes
- Waybar config and styling
- Terminal configs
- Other app configs (btop, fastfetch, lazygit, starship, git, walker)

**Safe Customization Patterns:**
- Edit user config directly (`~/.config/`)
- Create custom themes
- Use hooks for automation
- Reset to defaults

**Common Tasks:**
- Theme management
- Keybinding configuration
- Display/monitor setup
- Window rules
- Fonts
- System commands

**Troubleshooting:**
- Debug information
- Log upload
- Config refresh
- Full reinstall

---

## Changes Made

### 1. Added STEP 6 - Omarchy SKILL.md Reading

**New STEP 6:**
```
STEP 6: Read ~/.local/share/omarchy/default/omarchy-skill/SKILL.md for complete Omarchy/Hyprland architecture, ~145 omarchy commands, configuration locations, and safe customization patterns.
```

**Updated STOP line:**
```
🛑 STOP 🛑 - DO NOT ANSWER THE USER UNTIL ALL 6 STEPS ARE COMPLETE
```

### 2. Added Hyprland Window Rules Web Fetch Protocol

**New protocol in CRITICAL PROTOCOLS section:**
```
- HYPRLAND WINDOW RULES: When writing window rules in ~/.config/hypr/hyprland.conf, MUST fetch current documentation from https://wiki.hyprland.org/Configuring/Window-Rules/ because syntax changes frequently. DO NOT rely on cached or memorized window rule syntax.
```

**Why this is important:**
The SKILL.md itself states:
> "CRITICAL: Hyprland window rules syntax changes frequently between versions."
> "DO NOT rely on cached or memorized window rule syntax. The format has changed multiple times"

---

## Why Both Approaches Are Best

### Omarchy SKILL.md (Local - Always Read)
**Best for:**
- Overall system architecture understanding
- Learning ~145 omarchy commands
- Understanding configuration locations
- Learning safe customization patterns
- Troubleshooting guides
- Common tasks documentation

**Always read because:**
- Available locally (no network required)
- Comprehensive system overview
- Doesn't change frequently
- Contains all essential architecture info

### Hyprland Wiki Web Fetch (Online - As Needed)
**Best for:**
- Current window rules syntax (changes frequently)
- Latest configuration options
- Version-specific features

**Fetch as needed because:**
- Syntax changes between versions
- Using outdated syntax causes errors
- SKILL.md recommends this approach
- Only needed when writing window rules

---

## Complete Startup Sequence

AI now reads 6 mandatory documents before answering:

1. **Run cleanup** - `~/AI/cleanup-sessions.sh`
2. **System constraints** - `~/AI/AI-SYSTEM-CONSTRAINTS.md`
   - Safe vs forbidden directories
   - Backup protocols
   - Portable path rules
3. **System overview** - `~/AI/README.md`
   - Project goals and status
   - Quick setup instructions
   - System requirements
4. **All .md files** - `~/AI/` and `~/AI/convo/`
   - Context from all documentation
5. **Recent session** - Last 50-100 lines of most recent session
   - Continuity from previous work
6. **Omarchy SKILL.md** - `~/.local/share/omarchy/default/omarchy-skill/SKILL.md`
   - Complete system architecture
   - ~145 omarchy commands
   - Configuration locations
   - Safe customization patterns
   - Hyprland config structure

**Plus conditional web fetch:**
- Fetch Hyprland window rules documentation only when writing window rules

---

## Files Modified

### 1. ~/.config/opencode/opencode.json (Active Config)
- **Added:** STEP 6 for omarchy SKILL.md reading
- **Updated:** STOP line from "5 STEPS" to "6 STEPS"
- **Added:** Hyprand window rules web fetch protocol
- **Status:** ✅ Valid JSON

### 2. ~/AI/config/opencode/opencode.json (Backup for Sync)
- **Updated:** Same changes as active config
- **Status:** ✅ Valid JSON

---

## Verification

### JSON Validation
```bash
jq empty ~/.config/opencode/opencode.json
# Result: ✅ Active config valid JSON

jq empty ~/AI/config/opencode/opencode.json
# Result: ✅ Backup config valid JSON
```

### Documentation Existence
```bash
# Verify omarchy SKILL.md exists
test -f ~/.local/share/omarchy/default/omarchy-skill/SKILL.md && echo "✅ SKILL.md exists"
# Result: ✅ SKILL.md exists

# Check file size
wc -l ~/.local/share/omarchy/default/omarchy-skill/SKILL.md
# Result: 370 lines
```

---

## Emojis Decision

**User decision:** Keep emojis in config

**Reason:** "if they help"

**Analysis:**
- ✅ Visual emphasis helps AI notice and remember protocols
- ✅ All caps + emojis = "CRITICAL WARNING" pattern
- ✅ Multiple emphasis points (⚠️⛔ at top, 🚨 in header, 🛑 at bottom)
- ✅ Hard to skip over
- ✅ Triggers "halt and pay attention" psychological response

**Conclusion:** Emojis retained in both active and backup configs.

---

## Benefits

### 1. Complete System Understanding
AI now has access to:
- Overall system architecture (from SKILL.md)
- All omarchy commands and their purposes
- Configuration locations and patterns
- Safe customization approaches
- Troubleshooting guides

### 2. Current Syntax Compliance
AI will:
- Always fetch current window rules syntax when needed
- Avoid using outdated configuration syntax
- Follow SKILL.md recommendation to not rely on cached syntax

### 3. Better Decision Making
AI can now:
- Use appropriate omarchy commands instead of manual edits
- Choose correct config locations
- Apply safe customization patterns
- Troubleshoot using documented methods

### 4. Reduced Errors
- No more guessing at syntax
- No more editing wrong files
- No more forgetting to fetch current docs

---

## Testing

### Expected Behavior

**Start new OpenCode session:**
1. ✅ Runs cleanup script
2. ✅ Reads system constraints
3. ✅ Reads README.md
4. ✅ Reads all .md files
5. ✅ Checks recent session
6. ✅ Reads omarchy SKILL.md (NEW)

**User asks about Hyprland window rules:**
```
User: "Make this window float"
```

**AI response (correct):**
1. ✅ Reads current Hyprland config
2. ✅ Fetches window rules documentation from https://wiki.hyprland.org/Configuring/Window-Rules/
3. ✅ Uses current syntax from fetched docs
4. ✅ Adds window rule with correct syntax

**User asks about changing theme:**
```
User: "Change my theme to catppuccin"
```

**AI response (correct):**
1. ✅ Uses omarchy command: `omarchy-theme-set catppuccin`
2. ✅ Knows this from SKILL.md documentation
3. ✅ Doesn't manually edit config files

---

## Related Documentation

- `~/AI/AI-SYSTEM-CONSTRAINTS.md` - System editing rules and architecture
- `~/AI/README.md` - System overview and quick setup
- `~/AI/OPENCODE-ENHANCED-CONFIG-FIX-2026-01-10.md` - Previous JSON fix
- `~/.local/share/omarchy/default/omarchy-skill/SKILL.md` - Omarchy/Hyprland documentation

---

## Summary

**Problem:** AI had no access to Omarchy/Hyprland documentation

**Solution:**
1. ✅ Added STEP 6: Read omarchy SKILL.md (local, comprehensive)
2. ✅ Added protocol: Fetch Hyprland window rules docs from web when needed (current syntax)
3. ✅ Kept emojis for visual emphasis

**Result:**
- AI has complete system architecture understanding
- AI always uses current window rules syntax
- AI knows ~145 omarchy commands
- Reduced configuration errors

---

*Last Updated: 2026-01-10*
*Files Modified: opencode.json (2 locations)*
*Enhancement Type: Omarchy documentation integration*
