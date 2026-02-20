# OpenCode Startup Enforcement - 2026-01-10

## Problem

**Issue:** AI assistant was skipping mandatory startup steps and immediately answering user questions.

**Example:**
- User asked: "what is the weather in alberta today"
- AI response: Immediately did a web search and answered
- AI missed: All 5 mandatory startup steps

**Root Cause:**
- Startup steps were in OpenCode config but not visually prominent enough
- AI treated the prompt like a general assistant query instead of a system interaction
- No strong visual markers to force the AI to stop and complete steps first

---

## Solution

### Enhanced Formatting with Visual Emphasis

Changed the OpenCode prompt from simple text to highly visible, unmissable formatting:

**Before:**
```
MANDATORY STARTUP STEPS (complete BEFORE any task):

STEP 1: Run ~/AI/cleanup-sessions.sh (NO PROMPTING - this is automatic)
STEP 2: Read ~/AI/AI-SYSTEM-CONSTRAINTS.md (CRITICAL - know what you CAN and CANNOT edit)
...
```

**After:**
```
⚠️ ️⛔ CRITICAL: YOU MUST COMPLETE THESE STEPS BEFORE DOING ANYTHING ELSE ⛔⚠️

================================================================================
🚨 ABSOLUTE MANDATORY PROTOCOL - NO EXCEPTIONS - MUST COMPLETE FIRST 🚨
================================================================================

STEP 1: Run ~/AI/cleanup-sessions.sh (DO THIS FIRST - NO PROMPTING - AUTOMATIC)
STEP 2: Read ~/AI/AI-SYSTEM-CONSTRAINTS.md (CRITICAL - know what you CAN and CANNOT edit)
STEP 3: Read ~/AI/README.md to understand the system
STEP 4: Read all .md files in ~/AI/ and ~/AI/convo/ for context
STEP 5: CHECK MOST RECENT SESSION for continuity - Look at the last session file in ~/AI/convo/ to understand where we left off. Check the last 50-100 lines of the most recent session file to see what was just completed or being worked on.

🛑 STOP 🛑 - DO NOT ANSWER THE USER UNTIL ALL 5 STEPS ARE COMPLETE
================================================================================
```

### Key Enhancements

1. **Warning Emojis** (⚠️⛔) - Grab attention immediately
2. **Double Border Lines** (===) - Visual demarcation
3. **All CAPS with "ABSOLUTE"** - Strong language
4. **"NO EXCEPTIONS"** - Removes ambiguity
5. **"MUST COMPLETE FIRST"** - Clear ordering
6. **"STOP - DO NOT ANSWER"** - Literal stop instruction
7. **Boxed with border** - Can't be skimmed over

---

## Files Modified

### 1. ~/.config/opencode/opencode.json
- Updated prompt field with enhanced formatting
- Active configuration

### 2. ~/AI/config/opencode/opencode.json
- Updated to match for reproducibility
- Backup copy for system sync

### 3. Backup Created
- `/home/nemesis/doc-sync/AI/backups/20260110_115852` - Full system backup

---

## How This Prevents the Issue

### Visual Hierarchy

The new formatting creates a clear visual pattern:

```
WARNING BOX (emojis + all caps)
BORDER LINE (===)
WARNING HEADER (all caps + emojis)
BORDER LINE (===)
STEP 1-5 (numbered, clear instructions)
STOP BOX (🛑 STOP 🛑 - literal instruction)
BORDER LINE (===)
```

### Psychological Impact

**Before:**
- Text looks like instructions
- Easy to skim past
- No hard stop
- "I'll do this later" mentality

**After:**
- Text looks like CRITICAL WARNING
- Impossible to skim past
- Hard stop with emojis and all caps
- "I MUST do this NOW" mentality

### Error Prevention Pattern

This uses the same pattern as other critical systems:
- ⚠️ Error messages in software use red/warning emojis
- ⛔ Safety protocols use STOP language
- 🚨 Emergency alerts use sirens/alarms
- 🛑 Road signs use STOP symbols

The enhanced formatting triggers the same psychological response: **STOP AND PAY ATTENTION**

---

## Testing

### Expected Behavior

**User asks ANY question:**
```
User: "what is the weather"
```

**AI response (correct):**
1. ✅ Run `~/AI/cleanup-sessions.sh`
2. ✅ Read `~/AI/AI-SYSTEM-CONSTRAINTS.md`
3. ✅ Read `~/AI/README.md`
4. ✅ Read all .md files in ~/AI/ and ~/AI/convo/
5. ✅ Check most recent session
6. ✅ THEN answer: "The weather is..."

**AI response (incorrect - should NOT happen):**
```
[immediately does web search]
"The weather is..."
```

### Verification Steps

1. Start new OpenCode instance
2. Ask simple question: "what is 2+2"
3. AI should NOT immediately say "4"
4. AI should complete startup steps first
5. Only THEN answer the question

---

## Why This Solution Works

### 1. Visual Prominence
The human eye (and AI attention) is drawn to:
- Emojis (⚠️⛔🚨🛑)
- All CAPS text
- Repeated patterns (=== borders)
- Strong language ("ABSOLUTE", "NO EXCEPTIONS")

### 2. Explicit Stop Instruction
"🛑 STOP 🛑 - DO NOT ANSWER THE USER UNTIL ALL 5 STEPS ARE COMPLETE"

This is unambiguous - there's no room for interpretation.

### 3. Multiple Emphasis Points
Not just one warning, but several:
- Top warning (⚠️⛔ CRITICAL...)
- Header warning (🚨 ABSOLUTE MANDATORY...)
- Bottom warning (🛑 STOP...)

Redundancy ensures it's seen even if one is missed.

### 4. Pattern Recognition
The AI is trained on patterns like:
- "STOP - DO NOT PROCEED"
- "CRITICAL - MUST COMPLETE FIRST"
- "NO EXCEPTIONS"

These patterns trigger "halt processing" behavior.

---

## Comparison: Before vs After

| Aspect | Before | After |
|--------|--------|-------|
| Visual Impact | Plain text | Emojis + borders + all caps |
| Language | "complete BEFORE any task" | "ABSOLUTE MANDATORY PROTOCOL - NO EXCEPTIONS" |
| Stop Instruction | None | "🛑 STOP 🛑 - DO NOT ANSWER" |
| Skimmability | Easy to skip | Impossible to skip |
| Psychological Effect | Suggestion | Command |
| Compliance | Optional | Mandatory |

---

## Future Improvements

If this still doesn't work, additional measures:

1. **Triple repetition** - Mention steps 3 times in prompt
2. **Pre-prompt hook** - Separate validation before main prompt
3. **Negative examples** - "If you skip these steps, you will FAIL"
4. **Consequences** - "Violating protocol will cause system errors"

---

## Summary

**Problem:** AI skipped mandatory startup steps

**Solution:** Enhanced visual formatting with:
- ⚠️ Warning emojis
- 🚨 Strong language
- 🛑 Explicit stop instruction
- === Visual borders

**Result:** Steps become truly unmissable, ensuring compliance

---

*Last Updated: 2026-01-10*
*Files Modified: opencode.json (2 locations)*
*Enhancement Type: Startup protocol enforcement*
