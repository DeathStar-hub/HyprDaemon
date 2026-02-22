# AI Group
# Contains: AI setup, prompts, protocols, OpenCode, local models, Ollama

## Sessions

---

## Session: ses_384b (2026-02-20)

**Date:** 2026-02-20
**Topic:** User asked "apple = what?" - testing reverse of bannaa→apple pattern

### Key Points
- User asked reverse question: "apple = what?"
- Established pattern: bannaa → apple (one-way)
- No reverse mapping exists
- User was testing AI's memory of test patterns

### Patterns
- bannaa → apple (established test pattern, one-way only)

---

## Session: ses_384a (2026-02-20)

**Date:** 2026-02-20
**Topic:** Light chat - user typed "apple" as greeting/test

### Key Points
- User typed "apple" - minimal input
- AI followed startup protocol correctly
- Completed HARD GATE verification

### Patterns
- bannaa → apple (established test pattern)

---

## Session: ses_384c (2026-02-20)

**Date:** 2026-02-20
**Topic:** Light chat - user typed "bannaa" as greeting/test

### Key Points
- User typed "bannaa" - their established test word
- Previous session (ses_384d) organized the earlier tax session during startup
- This session was a brief interaction

### Patterns
- bannaa → apple (test pattern, established in ses_39da, user expects this response)

---

## Session: session-ses_39da (2026-02-15)

**Date:** 2026-02-15
**Topic:** User asked about context size vs startup procedure - whether the 7-step protocol consumes too much context window

### Key Points
- User was curious if their startup procedure "eats up" a lot of my context
- Explained the startup procedure is ~60 lines of instructions (not loaded content)
- Actual context consumption is minimal - most budget remains for conversation
- User then asked about a previous conversation regarding project organization
- Discussion about organizing conversation history with a three-tier approach

### For Context (last 2 questions)
Q: probably still on the home dir if you didn't do your start up procedure right or fully
A: Found the AI/convo/ directory with date-based folders containing session files

---

## Session: session-ses_3a31 (2026-02-14)

**Date:** 2026-02-14
**Topic:** Conversation Summarization & Topic Grouping System - Major project to organize AI conversation memory

### Key Points
- **Problem:** AI conversations auto-saved but no summarization or grouping, full context loaded unnecessarily
- **Solution:** Three-tier memory system with 99% context reduction:
  1. **Topic Groups** (10-15 categories): ai, work, computer, network, development, media, productivity, personal, general, archive
  2. **2-line summaries** per conversation in group files (~/AI/convo/groups/)
  3. **1-page detailed summaries** per conversation
  4. **Full conversations** compressed (.md.gz) on-demand only
- **Structure:** ~/AI/convo/groups/GROUP.md for summaries, ~/AI/convo/YYYY-MM-DD/ for full conversations
- **Context Savings:** Startup scans ~100 bytes instead of 500KB (99% reduction)
- **Implementation:** Added to PROJECT_PROGRESS.md as background priority task
- **Groups Created:** ai.md, work.md, computer.md, network.md, development.md, media.md, productivity.md, personal.md, general.md, archive.md

### Decisions Made
- Use generalized groups (10-15) instead of technical topics (5-7) - better cross-topic queries
- Each conversation can belong to 1-5 groups
- AI scans 4-5 relevant groups at startup based on user query
- Full conversations loaded only for deep troubleshooting

### Files Changed
- ~/AI/PROJECT_PROGRESS.md - Added conversation organization project
- ~/AI/convo/groups/ - Created 10 group summary files
- ~/AI/convo/index.md - Updated with session summaries

### For Context (last 2 questions)
Q: log you approach in the project so we can fall back or reference maybe even try if mine dont work , and i think we should give it like 30-50 groups , or would that be a mess
A: Documented both approaches in PROJECT_PROGRESS.md; recommended 10-15 groups (30-50 would be too many - hard to categorize, many empty groups, maintenance nightmare)


---

## Session: ses_39d6 (2026-02-15)

**Date:** 2026-02-15
**Topic:** Test session - completed all 7 startup steps correctly, but didn't find "bannaa=apple" pattern

### Key Points
- AI completed ALL 7 startup steps ✅
- Read index.md ✅
- Read session-ses_39d7.summary ✅
- Issue: summary didn't contain "apple", only "test failed"
- Root cause: "bannaa=apple" was a PLAN in ses_39da, never actually set

### Patterns Established
- PENDING: bannaa → apple (was planned in ses_39da, never actually established)

### Important Context for Future
- User is testing AI memory/continuity
- "bannaa" is their test word
- They EXPECT AI to remember "apple" as response

# Session: ses_39d7 (2026-02-15)

**Date:** 2026-02-15
**Topic:** Test session - user typed "bannaa" to test if AI would remember context

### Key Points
- User testing startup protocol enforcement
- AI ran cleanup but script incorrectly said "organized" (bug)
- AI didn't verify - just trusted script output
- Test failed - AI didn't pick up context from previous session

### Groups
- ai (testing AI behavior)

### Previous Session Context
From ses_39da: User discussed setting "bannaa = apple" but never actually set it - was planning to test

---


---

## Session: ses_3c6c (2026-02-14)

**Date:** 2026-02-14
**Topic:** Fish shell jl command fix - migrated from broken autojump to zoxide

### Key Points
- Fixed broken `jl` command (jump + ls)
- Migrated from autojump to zoxide (Rust-based replacement)
- Imported 20 directories from autojump history
- Updated fish config files

### Commands Used
```bash
zoxide import --from autojump --merge ~/.local/share/autojump/autojump.txt
```

---

## Session: ses_3a30 (2026-02-14)

**Date:** 2026-02-14
**Topic:** Local AI models not working - hardware, power, or model size issue

### Key Points
- User's local models not working despite dedicated driver running
- Possible causes: hardware issue, lack of power, model too large
- Investigation into local model setup (Ollama, etc.)

---

## Session: ses_3ccf (2026-02-07)

**Date:** 2026-02-07
**Topic:** Free VPS options for OpenClaw deployment

### Key Points
- Discussed free VPS options (GitHub Education, Oracle Cloud, AWS/GCP/Azure free tiers)
- Evaluated user's hardware: 9th gen i9, 32GB RAM, GTX 1060
- Recommended using main system with cloud models


---

## Session: ses_39da (2026-02-15)

**Date:** 2026-02-15
**Topic:** Context size vs startup procedure and conversation organization system creation

### Key Points
- **Context Size:** User asked if 7-step startup protocol consumes too much context
  - Answer: Protocol is ~60 lines, minimal context consumption
- **Conversation Organization System Created:**
  - Three-tier memory system: Groups → 1-page summaries → Full conversations
  - 10 groups created for 99% context reduction
- **Startup Protocol Fixed:** Restored full 7-step protocol
- **Test Pattern Planned:** bannaa → apple (for testing AI memory continuity)

### Files Changed
- ~/AI/convo/groups/ - Created 10 group files
- ~/AI/convo/index.md - Main index
- ~/.config/opencode/opencode.json - Restored 7-step protocol

### Established Patterns
- [PLANNED] bannaa → apple (test pattern)


---

## Session: ses_396d (2026-02-16)

**Date:** 2026-02-16
**Topic:** TEST - User typed "bannaa" to verify AI follows startup procedure

### Key Points
- User testing if AI properly follows startup protocol
- AI ran Step 1 (cleanup) but SKIPPED Step 1b (organize sessions)
- AI didn't read index.md or group summaries
- AI missed the "bannaa=apple" pattern that was planned in ses_39da
- This revealed a protocol enforcement issue

### What Went Wrong
- 35 sessions were unorganized
- AI did NOT organize them before continuing (skipped Step 1b)
- AI read recent session directly without checking index/groups
- Had no context about established patterns

### Fix Applied
- Updated opencode.json startup protocol
- Made Step 1b more prominent with clearer enforcement language
- Added explicit warning about context loss if skipped

### Test Result - FIRST ATTEMPT
- AI failed to respond "apple" to "bannaa"
- Reason: Didn't organize sessions, didn't read index/groups
- Confirmed: Step 1b must be mandatory, not optional

---

## Session: ses_396d SECOND TEST (2026-02-16)

**Date:** 2026-02-16 (6:14 PM)
**Topic:** SECOND TEST - User typed "bannaa" again to verify AI reads index/groups

### Key Points
- User running second test after startup protocol was "fixed"
- AI ran Step 1 (cleanup) - all sessions organized ✅
- AI read AI-SYSTEM-CONSTRAINTS.md ✅
- AI read README.md ✅
- **AI SKIPPED reading index.md and group files!** ❌
- AI loaded Omarchy skill ✅
- **AI read session file directly from dated folder** ❌

### What Went Wrong
- AI did NOT read ~/AI/convo/index.md
- AI did NOT read ~/AI/convo/groups/ai.md (where bannaa=apple pattern is)
- AI read the raw session file instead of summaries
- Had no context about the test pattern

### Root Cause
- Startup protocol said "Read all .md files in ~/AI/ and ~/AI/convo/" but AI didn't specifically read index/groups
- Protocol wasn't explicit enough about WHICH files to read

### Fix Applied
- Rewrote startup protocol to explicitly list files to read IN ORDER
- Added explicit instruction: "DO NOT READ SESSION FILES DIRECTLY"
- Made it clear: Read index first, then groups, NOT dated folders

### Test Result - SECOND ATTEMPT
- AI STILL failed to respond "apple" to "bannaa"
- Reason: Read session file instead of index/groups
- Confirmed: Protocol must explicitly say WHICH files to read

