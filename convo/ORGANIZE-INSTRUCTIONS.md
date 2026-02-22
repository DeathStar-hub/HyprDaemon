# Session Organization Instructions

## Is This Structure Named?

**You invented this!** This is your custom "Smart Context Retrieval" system. It's a variation of:
- **Tag-based file organization** (like Jekyll blogs using dates/tags)
- **Zettelkasten** (atomic note-taking with links)
- **Hierarchical temporal folders** (dated folders + topical subfolders)

But you've combined them in a unique way that works for AI conversation memory. Feel free to call it whatever you want!

## Your Custom Structure - "Smart Context Retrieval"

```
~/AI/convo/
├── index.md              ← 2-4 lines per session: summary + key points + topics + pkgs + refs
├── groups/
│   ├── ai/
│   │   └── 2026-02-22_jl-zoxide-fix.md   ← Individual summary files (~1 page)
│   ├── computer/
│   │   └── 2026-02-22_waybar-weather.md
│   └── ...
└── 2026-02-22/
    └── session-ses_xxx.md  ← Original session ONLY
```

## Index Format (2-4 lines per session)

```markdown
## 2026-02-22

**ses_3c18** | ai, computer
- Fixed jl command using zoxide symlink
- Updated opencode.json startup prompt to require running startup-protocol.sh
- Topics: fish shell, zoxide, opencode config
- PKGs: zoxide
- Groups: [ai/jl-zoxide-fix.md](groups/ai/jl-zoxide-fix.md) | Original: [2026-02-22/session-ses_3c18.md](2026-02-22/session-ses_3c18.md)
```

## Summary Format (~1 page, favor END of conversation)

```markdown
## Session: ses_3c18 (2026-02-22)

**Date:** 2026-02-22
**Groups:** ai, computer

### Summary
Brief 2-3 sentence overview of what was discussed.

### Key Points (in order of importance)
- Most important point first
- Second most important
- Third

### Decisions Made
- What was decided
- What was changed

### Files Modified
- ~/.config/fish/functions/jl.fish
- ~/.config/opencode/opencode.json

### Topics
fish shell, zoxide, opencode, startup protocol

### Packages
zoxide

### Patterns Established
- Any patterns the AI should remember for future sessions

### End Context (last 2 questions)
Q: [last question asked]
A: [brief answer]

Q: [second to last]
A: [brief answer]
```

## Steps for AI

### 1. After cleanup-sessions.sh finds new sessions
Read the session file from `~/AI/convo/YYYY-MM-DD/session-xxx.md`

### 2. Create Summary (~1 page)
- Read FIRST 50 lines to understand topic
- Read LAST 100 lines to capture final decisions/context
- Write ~1 page summary favoring the END of conversation
- Save to: `~/AI/convo/groups/GROUPNAME/YYYY-MM-DD_session-summary.md`

### 3. Determine Groups (1-3 max)
- ai, work, computer, network, development, media, productivity, personal, general, archive
- **CREATE NEW GROUPS if needed** - if a session covers a new topic that doesn't fit existing groups, create a new group subdirectory

### 4. Update Main Index
Add 2-4 lines to `~/AI/convo/index.md`:
```
**session-id** | group1, group2
- Key point 1
- Key point 2
- Topics: comma separated
- PKGs: packages mentioned (if any)
- Groups: [group/summary.md](groups/group/summary.md) | Original: [date/session-id.md](date/session-id.md)
```

## Important Rules

1. **Dated folders**: ONLY original session files - NO summaries
2. **Group folders**: Individual .md files per session (~1 page each)
3. **Index**: 2-4 lines with key points, topics, pkgs, and references
4. **Summary**: ~1 page, favor END of conversation for context
5. **Never overwrite** - create new summary file for each session
6. **Groups**: 1-3 groups max per session
7. **New topics**: Create new group subdirectories if session doesn't fit existing groups
