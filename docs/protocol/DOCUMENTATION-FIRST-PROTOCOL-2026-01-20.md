# Documentation-First Protocol - Startup Enhancement

**Date**: 2026-01-20
**Purpose**: Prevent assumption-based mistakes by requiring documentation review before project work

---

## 🚨 Problem Identified

During Walker theming project, the AI made **10+ failed attempts** due to making assumptions about how Walker's theme system works instead of reading documentation first.

### What Went Wrong:
1. **Repeatedly used CSS variables** from imported theme without testing if they resolved
2. **Assumed standard CSS behavior** - that `@import` includes variable inheritance
3. **Tried `!important` flags** instead of fixing the root cause (variable resolution)
4. **Made multiple attempts** with the same broken approach
5. **Did not search for documentation** until after multiple failures

### Impact:
- ❌ 10+ failed attempts before finding solution
- ❌ Border colors broken (white/transparent instead of magenta)
- ❌ Background became transparent
- ❌ User frustration from repeated mistakes
- ❌ Time wasted on trial-and-error instead of following proven methods

---

## ✅ Solution Implemented

### STEP 2: READ DOCUMENTATION FIRST - NO ASSUMPTIONS!

Added as **STEP 2** of mandatory startup protocol (between STEP 1 cleanup and STEP 3 constraints).

### Protocol Requirements:

**BEFORE MAKING ANY PROJECT/FEATURE CHANGES:**

1. **Search ~/AI for Existing Documentation:**
   ```bash
   find ~/AI -name "*[project-name]*.md" -o -name "*[component]*.md"
   ```

2. **Search ~/AI/projects/ for Project-Specific Docs:**
   ```bash
   ls ~/AI/projects/[category]/
   # Check for existing project documentation
   ```

3. **Search Online for Official Documentation:**
   - **GitHub repositories** - look for README, wiki, docs/ folders
   - **Official websites** - look for documentation, wiki, guides
   - **GitBook / Notion** - common documentation platforms
   - **Arch Wiki / distro wikis** - system-level documentation

4. **Examples - What Should Have Been Done First (Walker Theming):**
   - ❌ **WRONG**: "I'll just try CSS variables and see if they work"
   - ✅ **RIGHT**: "Let me search Walker documentation first"
     - Check: https://github.com/abenz1267/walker
     - Check: https://benz.gitbook.io/walker/customization/theme
     - Check: Examine default theme at `resources/themes/default/style.css`
     - **Result**: Would have learned immediately that Walker doesn't inherit CSS variables properly

### Mandatory Checklist Before Acting:

Before making any project/feature changes, AI must verify:

- [ ] **Searched ~/AI** for existing documentation?
- [ ] **Searched ~/AI/projects/** for project-specific docs?
- [ ] **Searched official sources** (GitHub, GitBook, wiki)?
- [ ] **Read and understood** the documentation?
- [ ] **Identified correct approach** from official sources?

### If Documentation Is Unclear:

If documentation is incomplete or confusing:

1. **Re-read more carefully**
2. **Search for examples** in documentation
3. **Look for troubleshooting sections** or FAQs
4. **Check GitHub issues** for similar problems
5. **Ask user for clarification** if truly unclear

---

## 📚 Documentation Sources Already Documented

### System-Wide Documentation:
- **README.md**: System overview, project goals, quick reference
- **AI-SYSTEM-CONSTRAINTS.md**: What files CAN/CANNOT edit, backup protocols
- **SKILL.md**: Complete Omarchy/Hyprland architecture (~145 commands, configs, patterns)
- **PROJECT_PROGRESS.md**: Incomplete projects, completion status, recent changes

### Project-Specific Documentation:
- **Walker**: `~/AI/projects/hypr/walker/walker-rounded-corners-complete.md`
- **Battery Widget**: `~/AI/idle-timeout-control.md`
- **CPU Frequency**: `~/AI/cpu-frequency-enhancement.md`
- **Weather Widget**: `~/AI/projects/hypr/weather widget.md`
- **And more...**

### Online Sources to Check:
- **Walker**: https://github.com/abenz1267/walker + https://benz.gitbook.io/walker
- **Hyprland**: https://wiki.hyprland.org/ (CRITICAL: Always fetch for current window rules syntax)
- **GTK4**: https://docs.gtk.org/gtk4/ (Walker is built on GTK4)
- **Omarchy**: GitHub repository and local `~/.local/share/omarchy/default/omarchy-skill/SKILL.md`

---

## 🔄 Startup Protocol Updates

### Before (6 Steps):
```
STEP 1: Run ~/AI/cleanup-sessions.sh
STEP 2: Read ~/AI/AI-SYSTEM-CONSTRAINTS.md
STEP 3: Read ~/AI/README.md
STEP 4: Read all .md files in ~/AI/ and ~/AI/convo/
STEP 5: CHECK MOST RECENT SESSION for continuity
STEP 6: Read ~/.local/share/omarchy/default/omarchy-skill/SKILL.md
```

### After (7 Steps):
```
STEP 1: Run ~/AI/cleanup-sessions.sh
STEP 2: 🚨 READ DOCUMENTATION FIRST - NO ASSUMPTIONS! 🚨
       - Search ~/AI/, ~/projects/, and official sources
       - NEVER bumble along with assumptions
       - Read documentation before acting
STEP 3: Read ~/AI/AI-SYSTEM-CONSTRAINTS.md
STEP 4: Read ~/AI/README.md
STEP 5: Read all .md files in ~/AI/ and ~/AI/convo/
STEP 6: CHECK MOST RECENT SESSION for continuity
STEP 7: Read ~/.local/share/omarchy/default/omarchy-skill/SKILL.md
```

---

## 📋 Files Updated

### Documentation Files:
1. **~/AI/README.md**
   - Added STEP 2 with full documentation-first protocol
   - Added visual emphasis (🚨 emojis, all caps, bold text)
   - Added checklist to verify documentation search
   - Added consequences of skipping documentation
   - Added Walker theming example

2. **~/.config/opencode/opencode.json** (Active Config)
   - Updated startup prompt from 6 steps to 7 steps
   - Added STEP 2 with complete documentation-first protocol
   - Added checklist requirements
   - Added "what happens when you skip documentation" section

3. **~/AI/config/opencode/opencode.json** (Backup for Sync)
   - Synced with active config for reproducibility

4. **~/AI/PROJECT_PROGRESS.md**
   - Added 2026-01-20 section documenting Walker project
   - Added documentation-first protocol implementation details
   - Added lessons learned section
   - Updated last updated dates

5. **~/AI/projects/hypr/walker/walker-rounded-corners-complete.md**
   - Complete implementation guide
   - Full analysis of what went wrong
   - Walker documentation sources
   - Troubleshooting guide
   - Lessons learned for future reference

---

## 🎯 Expected Outcomes

### With Documentation-First Protocol:

**BEFORE:**
- ❌ Make assumptions about how system works
- ❌ Try multiple broken approaches
- ❌ Waste time on trial-and-error
- ❌ User frustration from repeated mistakes

**AFTER:**
- ✅ Search for and read documentation first
- ✅ Understand system before making changes
- ✅ Use proven approaches from official sources
- ✅ Faster completion with fewer attempts
- ✅ Reduced user frustration

### Example Scenarios:

#### Scenario 1: Walker Theming (What Just Happened)
**Without Protocol:**
- ❌ Try CSS variables (fail)
- ❌ Try `!important` (fail)
- ❌ Try variations (fail x10)
- ❌ Finally search documentation after 10 attempts

**With Protocol:**
- ✅ STEP 2: Search Walker documentation
- ✅ Read GitBook theming guide
- ✅ Examine default theme
- ✅ Understand that variables don't inherit
- ✅ Use explicit values from start
- ✅ **Complete in 1 attempt**

#### Scenario 2: Hyprland Window Rules
**Without Protocol:**
- ❌ Use memorized window rule syntax (might be outdated)
- ❌ Get errors when syntax changed
- ❌ Waste time troubleshooting

**With Protocol:**
- ✅ STEP 2: Search Hyprland window rules documentation
- ✅ Fetch current documentation from wiki
- ✅ Use correct current syntax
- ✅ **No errors**

---

## 🔍 How to Search for Documentation

### Basic Search Commands:

```bash
# 1. Search AI directory for relevant documentation
find ~/AI -name "*[keyword]*.md"

# 2. Search projects folder
find ~/AI/projects -name "*[keyword]*.md"

# 3. Search for recent documentation
ls -lt ~/AI/*.md | head -10

# 4. Search in project category
ls ~/AI/projects/[category]/

# 5. Check for keywords in all documentation
grep -r "[keyword]" ~/AI/*.md ~/AI/projects/
```

### Documentation Search Checklist:

Before starting project work, verify:

- [ ] **Local documentation searched?**
  - [ ] ~/AI/*.md
  - [ ] ~/AI/projects/**/*.md
  - [ ] Project-specific folders

- [ ] **Official documentation searched?**
  - [ ] GitHub repository (README, wiki, docs/)
  - [ ] Official website (documentation, wiki, guides)
  - [ ] GitBook/Notion/other platforms
  - [ ] Arch Wiki / distro wikis

- [ ] **Documentation read and understood?**
  - [ ] Read relevant sections completely
  - [ ] Understood system architecture
  - [ ] Identified correct approach
  - [ ] Found examples or troubleshooting info

---

## 💡 Key Learnings

### 1. Assumptions Are Dangerous
Making assumptions about how a system works without reading documentation leads to:
- Multiple failed attempts
- Wrong approaches based on incorrect understanding
- Wasted time and user frustration

### 2. Documentation Exists for a Reason
Every project/application has:
- Official documentation explaining how it works
- Troubleshooting guides for common issues
- Examples showing correct usage
- Wikis/forums discussing edge cases

### 3. Local Documentation is Valuable
The ~/AI directory contains:
- Complete project history
- Lessons learned from past mistakes
- Troubleshooting guides
- Proven approaches that work

### 4. Reading Documentation First Saves Time
- Fewer attempts needed (1-2 vs 10+)
- Correct approach from start
- Proven methods from official sources
- Less troubleshooting and debugging

---

## 📊 Impact Measurement

### Walker Theming Project (Case Study):

| Metric | Without Protocol | With Protocol |
|---------|----------------|---------------|
| Attempts to complete | 10+ | 1 |
| Time spent | ~1 hour | ~10 minutes |
| User frustration | High | Low |
| Documentation read | After failures | Before work |
| Learning outcome | Trial-and-error | From official sources |

---

## 🚀 Future Protocols

### For New AI Sessions:
1. **STEP 2 is now mandatory** - Cannot skip documentation search
2. **Checklist must be verified** before making changes
3. **Examples provided** of what to search and how
4. **Consequences documented** of skipping documentation

### For Existing AI Sessions:
- Update protocols immediately
- Emphasize STEP 2 importance
- Use Walker theming as example of what goes wrong
- Reference existing documentation sources

### For Documentation Maintenance:
- Keep project docs updated with lessons learned
- Document what went wrong and how to prevent it
- Include troubleshooting guides
- Link to official sources

---

## ✅ Implementation Status

- [x] STEP 2 added to startup protocol (README.md)
- [x] STEP 2 added to OpenCode config (7 steps total)
- [x] Visual emphasis added (🚨 emojis, all caps, bold text)
- [x] Checklist requirements included
- [x] Walker theming example documented
- [x] Consequences of skipping documentation explained
- [x] Documentation search commands provided
- [x] All configs synced to ~/AI/config/
- [x] PROJECT_PROGRESS.md updated
- [x] Walker rounded corners documented with lessons learned
- [x] Quick reference updated in README.md

---

*Documentation Created: 2026-01-20*
*Protocol Status: ✅ Active and Enforced*
*Startup Steps: 7 (increased from 6)*
*Walker Project: ✅ Complete with lessons learned*
*All Configs: ✅ Backed up and synced*
