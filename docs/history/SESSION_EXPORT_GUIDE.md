# Opencode Session Export - Updated Guide

## Quick Reference

### List All Sessions
```bash
~/AI/export_current_session.sh --list
```

### List Recent Sessions (Last 10)
```bash
~/AI/export_current_session.sh --recent
```

**Best option for multiple sessions** - shows only recent ones with titles and timestamps.

### Export Specific Session
```bash
~/AI/export_current_session.sh ses_4764702e2ffejetaRI10FVaTR4
```

### Export Most Recent Session (Default)
```bash
~/AI/export_current_session.sh
```

### Interactive Selection (fzf)
```bash
~/AI/export_current_session.sh --interactive
# or
~/AI/export_current_session.sh -i
```

**Best option** - fuzzy search and select from all sessions with titles.

## Multiple Sessions

If you have multiple sessions open and need to identify yours:

1. **Use `--recent`** - Shows only last 10 sessions with:
   - Session ID
   - Title (identifies the session topic)
   - Last updated timestamp

2. **Use `--interactive`** - Opens fzf search:
   - Type to search by title or session ID
   - Arrow keys to navigate
   - Enter to select
   - ESC to cancel

3. **Compare timestamps** - Most recently updated is likely your current session

## Session Selection Logic

- **No argument:** Exports most recently updated session
- **--list:** Lists ALL sessions (may be overwhelming)
- **--recent:** Lists only last 10 sessions (recommended)
- **--interactive/-i:** Fuzzy search through all sessions (recommended)
- **With session ID:** Exports that specific session

## Example Usage

```bash
# See only recent sessions
~/AI/export_current_session.sh --recent

# Interactive search and select
~/AI/export_current_session.sh -i

# Export most recent
~/AI/export_current_session.sh
```

## Output Location

All exports go to: `~/AI/sessions/YYYY-MM-DD/`

Files created:
- `session-<id>.json` - Full session data (importable)
- `session-<timestamp>.md` - Human-readable summary

## Start Session with Auto-Export

```bash
~/AI/context/start_and_export.sh
# Use opencode normally
# Exit - session auto-exports
```

## Import a Session

```bash
cd ~/AI/sessions/YYYY-MM-DD/
opencode import session-<id>.json
```

## Finding Your Current Session

Since opencode doesn't show session ID in the UI:

1. **Use `--recent`** - Look for the session with the title that matches what you're working on
2. **Use `--interactive`** - Search by your session topic
3. **Check timestamp** - Your current session will be the most recently updated

## Session Titles

Session titles usually reflect the first message or topic. Example:
- "Reading ~/AI dir and session**.mds in home dir"
- "New session - 2026-01-04T16:04:18.453Z"
- "Debugging omarchy menu, reading ~/AI dir for changes"

Use these titles to identify your session in `--recent` or `--interactive` mode.
