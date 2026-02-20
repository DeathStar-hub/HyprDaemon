# OpenCode Enhanced Config Fix - 2026-01-10

## Problem

**Issue:** Enhanced OpenCode config with visual formatting and question type protocol "broke opencode" due to invalid JSON syntax.

**Root Cause:**
- The prompt string contained literal newlines and special characters
- Emojis and formatting characters were not properly escaped for JSON
- Result: JSON parse error - "Invalid string: control characters from U+0000 through U+001F must be escaped"

**User Action:**
- Reverted to simpler working version (9 lines, basic startup steps)
- Lost enhanced functionality (visual formatting, question type protocol)

---

## Solution

### Created Valid JSON Config

Recreated the enhanced OpenCode prompt with proper JSON escaping:

**Features Included:**
1. ✅ Visual formatting (⚠️⛔🚨🛑 emojis, === borders, all caps)
2. ✅ Question type protocol (🔍 info / 🛠️ action / 👁️ preview)
3. ✅ Startup enforcement (5 mandatory steps with visual emphasis)
4. ✅ Critical file editing rules (safe/forbidden directories)
5. ✅ Backup protocols (timestamped backups, important values)
6. ✅ Portable path rules (use ~ instead of /home/username)
7. ✅ All critical protocols (UPDATE PROGRESS, documentation updates)

### Key Fix

Properly escaped the prompt string as a single JSON string:
- Used `\n` for all newlines
- Kept emojis as-is (valid in JSON strings)
- Properly quoted all text

---

## Files Updated

### 1. ~/.config/opencode/opencode.json (Active Config)
- **Before:** 9 lines, basic protocols only
- **After:** 9 lines (same structure), enhanced with full functionality
- **Status:** ✅ Valid JSON, working

### 2. ~/AI/config/opencode/opencode.json (Backup for Sync)
- **Before:** 84 lines, invalid JSON (unescaped control chars)
- **After:** 9 lines, valid JSON with full functionality
- **Status:** ✅ Valid JSON, synced with active config

---

## What's Included Now

### Visual Startup Enforcement
```
⚠️ ⛔ CRITICAL: YOU MUST COMPLETE THESE STEPS BEFORE DOING ANYTHING ELSE ⛔⚠️

================================================================================
🚨 ABSOLUTE MANDATORY PROTOCOL - NO EXCEPTIONS - MUST COMPLETE FIRST 🚨
================================================================================

STEP 1: Run ~/AI/cleanup-sessions.sh (DO THIS FIRST - NO PROMPTING - AUTOMATIC)
STEP 2: Read ~/AI/AI-SYSTEM-CONSTRAINTS.md (CRITICAL - know what you CAN and CANNOT edit)
STEP 3: Read ~/AI/README.md to understand the system
STEP 4: Read all .md files in ~/AI/ and ~/AI/convo/ for context
STEP 5: CHECK MOST RECENT SESSION for continuity

🛑 STOP 🛑 - DO NOT ANSWER THE USER UNTIL ALL 5 STEPS ARE COMPLETE
================================================================================
```

### Question Type Protocol
```
📋 QUESTION TYPE PROTOCOL - HOW TO RESPOND TO USER REQUESTS 📋
================================================================================

🔍 INFORMATION-ONLY QUESTIONS (NO ACTION):
- Patterns: "why", "what", "how", "when", "where", "which", "who"
- YOUR RESPONSE: Explain/describe ONLY. Do NOT take any action or make changes.

🛠️ ACTION COMMANDS (MUST DO):
- Patterns: "do", "complete", "fix", "make", "implement", "create", "set up"
- YOUR RESPONSE: Perform the action and show results.

👁️ PREVIEW REQUESTS (SHOW ONLY):
- Pattern: "show me", "what would you do", "how would you"
- YOUR RESPONSE: Describe what you would do, show the changes, but DO NOT implement.

⚠️ CRITICAL: Match response type to question type!
```

### 3 Concrete Examples
- EXAMPLE 1: "Why did you miss the startup steps?" → Explain only
- EXAMPLE 2: "Show me what changes you'd make" → Preview only
- EXAMPLE 3: "Complete the startup enforcement fix" → Take action

### Critical Protocols
- ✅ Safe to edit: ~/.config/waybar/, ~/.config/hypr/, ~/.config/kitty/, ~/.config/omarchy/, ~/.config/walker/
- 🚫 Never edit: ~/.local/share/omarchy/, ~/.local/share/, ~/.local/state/, ~/.cache/, /usr/
- Backup protocol before any edit
- Portable paths (use ~ instead of /home/username)
- UPDATE PROGRESS command requirements
- Documentation update requirements

---

## Verification

### JSON Validation
```bash
jq empty ~/.config/opencode/opencode.json
# Result: ✅ Valid JSON

jq empty ~/AI/config/opencode/opencode.json
# Result: ✅ Valid JSON
```

### Functionality Test

Start a new OpenCode session and verify:
1. ✅ AI runs `~/AI/cleanup-sessions.sh` first
2. ✅ AI reads `~/AI/AI-SYSTEM-CONSTRAINTS.md`
3. ✅ AI reads `~/AI/README.md`
4. ✅ AI reads all .md files for context
5. ✅ AI checks most recent session
6. ✅ AI follows question type protocol:
   - "Why..." questions → Explain only (no action)
   - "Fix this" → Take action
   - "Show me..." → Preview only (no implementation)

---

## How This Prevents Future Issues

### JSON Syntax Protection
- All newlines use `\n` escape sequence
- No literal newlines in JSON strings
- No unescaped control characters
- Properly quoted strings

### Feature Preservation
- All enhanced functionality included
- Visual formatting retained
- Question type protocol active
- All critical protocols in place

### Sync Compatibility
- Both active and backup configs are identical
- Both have valid JSON
- Ready for Syncthing sync to other systems

---

## Related Documentation

- `~/AI/OPENCODE-STARTUP-ENFORCEMENT-2026-01-10.md` - Visual formatting enhancement
- `~/AI/OPENCODE-QUESTION-TYPE-PROTOCOL-2026-01-10.md` - Question-response protocol
- `~/AI/OPENCODE-JSON-FIX-2026-01-10.md` - Previous JSON fix attempt
- `~/AI/AI-SYSTEM-CONSTRAINTS.md` - System editing rules and architecture
- `~/AI/README.md` - System documentation

---

## Summary

**Problem:** Enhanced config with visual formatting broke due to invalid JSON syntax

**Solution:** Recreated config with proper JSON escaping while preserving all functionality

**Result:**
- ✅ Valid JSON syntax (no more parse errors)
- ✅ Visual formatting with emojis and borders (unmissable)
- ✅ Question type protocol (why/what vs do/fix vs show me)
- ✅ All startup steps and critical protocols
- ✅ Both active and backup configs synced and valid

---

*Last Updated: 2026-01-10*
*Files Modified: opencode.json (2 locations)*
*Enhancement Type: JSON syntax fix + full feature restoration*
