# AI Instance Startup Checklist

## 🐢 SPEED vs QUALITY: CHOOSE QUALITY

**Remember:** The user wants it done **RIGHT**, not fast.

- ⏱️ Fast + Wrong = Waste everyone's time
- 🐢 Slow + Correct = Efficient and valuable

**Take the extra 60 seconds. Load all context. Get it right the first time.**

---

## ⚠️ MANDATORY - Complete ALL steps before ANY task

### Pre-Task Initialization (ALWAYS DO FIRST)

- [ ] **Step 1:** Run `~/AI/startup-protocol.sh`
  - This cleans up old sessions and loads context

- [ ] **Step 2:** Load relevant SKILL files
  - For Hyprland/Waybar/Omarchy: `skill Omarchy`
  - Check `~/.claude/skills/` for available skills
  - **CRITICAL:** Load skills BEFORE reading config files or making changes

- [ ] **Step 3:** Read conversation continuity
  - Check `~/AI/convo/YYYY-MM-DD/` for recent sessions
  - Read last 50-100 lines of most recent `.md` file
  - Note what was being worked on

- [ ] **Step 4:** Check project context
  - Read `~/AI/PROJECT_PROGRESS.md` if exists
  - Check `~/AI/README.md` for system overview
  - Look for any `.md` files in `~/AI/projects/` relevant to current task

### Task-Specific Protocol

Before starting ANY task:

1. **Is it an Omarchy/Hyprland/Waybar task?**
   - Load Omarchy skill FIRST
   - Check `~/.local/share/omarchy/default/` for defaults
   - Remember: edit in `~/.config/` NEVER in `~/.local/share/omarchy/`

2. **Does it involve config file edits?**
   - Create backup first: `cp file file.bak.$(date +%s)`
   - Read current config completely before editing
   - Check for errors after: `hyprctl configerrors` (for Hyprland)

3. **Is this continuing previous work?**
   - Read the most recent conversation file
   - Check git status if in a repo
   - Review PROJECT_PROGRESS.md for status

### 🔐 Terminal & Sudo Protocol (CRITICAL)

When the task requires sudo/password:

**NEVER run `sudo <command>` directly** - it will fail without interactive password input.

**STANDARD APPROACH:** Open terminal with command pre-filled:
```bash
alacritty -e sudo pacman -S <package>
```

This:
- Opens terminal with command ready
- User types password → presses enter
- AI NEVER sees the password (typed locally in terminal)

**Security Note:** AI sees the command text but NEVER the password. This is secure because:
- Password is typed into local terminal
- Password never transmitted to AI cloud

**Alternative for maximum privacy:** Tell user the command to run manually, AI sees nothing.

### 📦 Package Installation Helper

**For installing packages via paru/yay (when fish has startup scripts):**
```bash
# Use kitty with bash (bypasses fish startup scripts that run fastfetch, etc.)
~/AI/scripts/install-pkg.sh <package-name>

# Example:
~/AI/scripts/install-pkg.sh glmark2
```

This opens kitty with bash instead of fish, avoiding all the startup animations (fastfetch, sl, rain, asciiquarium, etc.)

### Quick Commands Reference

```bash
# Run full startup protocol
~/AI/startup-protocol.sh

# Check Hyprland config errors (after any hyprland.conf changes)
hyprctl configerrors

# List all Omarchy commands
compgen -c | grep -E '^omarchy-' | sort -u

# Load a skill
skill <name>

# Backup a config file
cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.bak.$(date +%s)
```

### Common Mistakes to AVOID

❌ **DON'T:** Start editing files before loading relevant skills  
✅ **DO:** Load skills first, they contain critical safety rules

❌ **DON'T:** Edit files in `~/.local/share/omarchy/`  
✅ **DO:** Edit in `~/.config/` only

❌ **DON'T:** Assume syntax from memory for Hyprland configs  
✅ **DO:** Fetch current documentation - syntax changes frequently

❌ **DON'T:** Skip checking conversation history  
✅ **DO:** Read recent sessions for continuity

❌ **DON'T:** Skip running cleanup script  
✅ **DO:** Run `~/AI/cleanup-sessions.sh` first

---

**REMINDER:** This checklist is in my real-time working memory. I should reference it at the start of EVERY session to ensure I don't skip critical initialization steps.
