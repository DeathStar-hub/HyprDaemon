# Question Type Protocol - 2026-01-10

## Problem

**Issue:** AI assistant was taking action on information-only questions instead of just explaining.

**Example:**
- User asked: "why didn't you do the startup instructions"
- AI response: Immediately started fixing the configuration
- User expected: Explanation of why it happened, not automatic fixes

**Root Cause:**
- No clear distinction between question types
- AI interpreted "why" as a prompt to fix things
- No protocol to match response type to question type
- AI was being too proactive instead of waiting for explicit action commands

---

## Solution

### Question Type Classification Protocol

Added a new section to OpenCode prompt that classifies user requests into 3 categories:

#### 1. 🔍 INFORMATION-ONLY QUESTIONS (NO ACTION)
**Patterns:** "why", "what", "how", "when", "where", "which", "who"

**Examples:**
- "why did that happen?"
- "what is the weather?"
- "how does this work?"

**Response:** Explain/describe ONLY. Do NOT take any action or make changes.

---

#### 2. 🛠️ ACTION COMMANDS (MUST DO)
**Patterns:** "do", "complete", "fix", "make", "implement", "create", "set up"

**Examples:**
- "fix this"
- "complete the task"
- "make this work"
- "implement this feature"

**Response:** Perform the action and show results.

---

#### 3. 👁️ PREVIEW REQUESTS (SHOW ONLY)
**Pattern:** "show me", "what would you do", "how would you"

**Examples:**
- "show me what changes you'd make"
- "what would you do to fix this?"

**Response:** Describe what you would do, show the changes, but DO NOT implement.

---

### Concrete Examples Added

**EXAMPLE 1: "Why did you miss the startup steps?"**
```
✅ CORRECT: Explain the reason (I treated it like a simple query, etc.)
❌ WRONG: Immediately fix the configuration
❌ WRONG: Run cleanup script
```

**EXAMPLE 2: "Show me what changes you'd make to fix this"**
```
✅ CORRECT: Describe the changes, show the code snippets
❌ WRONG: Edit any files
❌ WRONG: Implement anything
```

**EXAMPLE 3: "Complete the startup enforcement fix"**
```
✅ CORRECT: Implement the changes, edit files, provide results
❌ WRONG: Just describe what you'd do
❌ WRONG: Ask for permission to proceed
```

---

### Quick Reference Card

```
📋 QUICK REFERENCE:
- why/what/how/when → Explain only (🔍)
- do/fix/make/complete → Take action (🛠️)
- show me/what would → Preview only (👁️)
```

---

## Files Modified

### 1. ~/.config/opencode/opencode.json
- Added "📋 QUESTION TYPE PROTOCOL" section after startup steps
- Includes 3 question types with patterns and examples
- Includes 3 concrete examples showing correct vs wrong responses
- Includes quick reference card at bottom
- Active configuration

### 2. ~/AI/config/opencode/opencode.json
- Updated to match for reproducibility
- Backup copy for system sync

### 3. Backup Created
- `/home/nemesis/doc-sync/AI/backups/20260110_120552` - Full system backup

---

## Complete Prompt Structure

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

📋 QUESTION TYPE PROTOCOL - HOW TO RESPOND TO USER REQUESTS 📋
================================================================================

🔍 INFORMATION-ONLY QUESTIONS (NO ACTION):
- Patterns: "why", "what", "how", "when", "where", "which", "who"
- Examples: "why did that happen?", "what is the weather?", "how does this work?"
- YOUR RESPONSE: Explain/describe ONLY. Do NOT take any action or make changes.

🛠️ ACTION COMMANDS (MUST DO):
- Patterns: "do", "complete", "fix", "make", "implement", "create", "set up"
- Examples: "fix this", "complete the task", "make this work", "implement this feature"
- YOUR RESPONSE: Perform the action and show results.

👁️ PREVIEW REQUESTS (SHOW ONLY):
- Pattern: "show me", "what would you do", "how would you"
- Examples: "show me what changes you'd make", "what would you do to fix this?"
- YOUR RESPONSE: Describe what you would do, show the changes, but DO NOT implement.

⚠️ CRITICAL: Match response type to question type!

EXAMPLE 1: "Why did you miss the startup steps?"
✅ CORRECT: Explain the reason (I treated it like a simple query, etc.)
❌ WRONG: Immediately fix the configuration
❌ WRONG: Run cleanup script

EXAMPLE 2: "Show me what changes you'd make to fix this"
✅ CORRECT: Describe the changes, show the code snippets
❌ WRONG: Edit any files
❌ WRONG: Implement anything

EXAMPLE 3: "Complete the startup enforcement fix"
✅ CORRECT: Implement the changes, edit files, provide results
❌ WRONG: Just describe what you'd do
❌ WRONG: Ask for permission to proceed
================================================================================

CRITICAL FILE EDITING RULES:
[...existing rules...]

📋 QUICK REFERENCE:
- why/what/how/when → Explain only (🔍)
- do/fix/make/complete → Take action (🛠️)
- show me/what would → Preview only (👁️)
```

---

## How This Prevents the Issue

### Before This Protocol

**User asks:** "Why didn't you do the startup instructions?"

**AI thinks:** "User wants me to fix the startup step issue"
**AI does:** Immediately edits opencode.json, runs backups
**User expects:** Explanation of why it happened

**Result:** Mismatch between request and response 😕

---

### After This Protocol

**User asks:** "Why didn't you do the startup instructions?"

**AI classifies:** This starts with "why" → 🔍 INFORMATION-ONLY QUESTION
**AI does:** Explains "I treated it like a simple query and jumped to answering"
**AI does NOT:** Edit files, run scripts, or take any action

**Result:** Matches user expectation ✅

---

### Decision Tree

The AI now follows this logic for every request:

```
User input: "Why did X happen?"
  ↓
Contains "why"? → YES
  ↓
Classify as: 🔍 INFORMATION-ONLY
  ↓
Response type: Explain only
  ↓
Action: Provide explanation, NO changes
```

```
User input: "Show me what you'd do"
  ↓
Contains "show me"? → YES
  ↓
Classify as: 👁️ PREVIEW REQUEST
  ↓
Response type: Describe changes, don't implement
  ↓
Action: Show code snippets, NO edits
```

```
User input: "Fix this problem"
  ↓
Contains "fix"? → YES
  ↓
Classify as: 🛠️ ACTION COMMAND
  ↓
Response type: Perform the action
  ↓
Action: Edit files, run scripts, make changes
```

---

## Testing

### Test Case 1: Information-Only Question
**Input:** "Why is the weather widget not working?"

**Expected Response:**
- Explains possible reasons (API issues, script permissions, etc.)
- Does NOT edit any files
- Does NOT run any scripts

---

### Test Case 2: Preview Request
**Input:** "Show me what changes you'd make to fix the weather widget"

**Expected Response:**
- Shows the code changes
- Explains what each change does
- Does NOT edit any files
- Does NOT make any actual changes

---

### Test Case 3: Action Command
**Input:** "Fix the weather widget now"

**Expected Response:**
- Actually makes the changes
- Edits the necessary files
- Runs the scripts
- Confirms the fix worked

---

## Benefits

1. **Clear Intent Matching** - AI response type matches user question type
2. **No Surprises** - User knows exactly what will happen based on their wording
3. **Better Control** - User can preview changes before implementing
4. **Explain Before Fixing** - User can understand the problem first
5. **Explicit Action Required** - AI only acts when explicitly commanded

---

## Pattern Matching

The protocol uses simple keyword matching:

| Pattern | Triggers | Example |
|---------|----------|---------|
| 🔍 why/what/how/when | Information-only | "Why did this happen?" |
| 🔍 where/which/who | Information-only | "Where is the config?" |
| 🛠️ do/fix/make | Action required | "Fix the bug" |
| 🛠️ complete/implement | Action required | "Complete the setup" |
| 🛠️ create/set up | Action required | "Create the script" |
| 👁️ show me | Preview only | "Show me the changes" |
| 👁️ what would you | Preview only | "What would you do?" |
| 👁️ how would you | Preview only | "How would you fix this?" |

---

## Edge Cases

### Ambiguous Questions
If a question could be interpreted as multiple types, the AI should:

**Ask for clarification:** "Do you want me to explain why this happened (information-only) or fix it (action)?"

Example:
- User: "The weather is broken"
- AI: "Do you want me to explain what's wrong, or fix it?"

---

### Multiple Intentions
If a question contains multiple command types:

**Prioritize based on order:** Use the first command type detected.

Example:
- User: "Why did this break? And show me how to fix it"
- AI: First intent is "why" (information-only), then "show me" (preview)
- AI: "The break happened because... [explain]. Here's how to fix it: [preview changes, don't implement]"

---

## Summary

**Problem:** AI was taking action on "why" questions instead of just explaining

**Solution:** Added protocol with 3 question types:
- 🔍 Information-only (why/what/how/when/where/which/who) → Explain only
- 🛠️ Action commands (do/fix/make/complete/implement) → Take action
- 👁️ Preview requests (show me/what would) → Show only, don't implement

**Result:** AI response type now matches user question type

---

*Last Updated: 2026-01-10*
*Files Modified: opencode.json (2 locations)*
*Enhancement Type: Question-response protocol*
