# Opencode Session Management (Updated)

This system provides clean session export using opencode's built-in export functionality.

## Quick Start

**Option 1: Start session and auto-export on exit**
```bash
~/AI/context/start_and_export.sh
```

This starts opencode normally, and when you exit, it automatically exports the session to:
- `~/AI/sessions/YYYY-MM-DD/session-<session-id>.json` (Full session data)
- `~/AI/sessions/YYYY-MM-DD/session-<timestamp>.md` (Readable summary)

**Option 2: Export current session**
```bash
~/AI/export_current_session.sh
```

Exports the most recent session without restarting.

## Why This Approach?

The old system (raw terminal capture) had issues:
- Captured TUI rendering artifacts (ANSI codes, kitty graphics)
- Required complex parsing to extract conversation
- Results were imperfect and fragmented

**New approach uses opencode's `export` command:**
- Clean JSON export with complete conversation
- No TUI artifacts
- Includes all messages, tool calls, and metadata
- Importable with `opencode import`

## File Structure

```
~/AI/
├── sessions/                      # Auto-created
│   └── 2026-01-04/               # Date-organized
│       ├── session-<id>.json     # Full session data
│       └── session-<time>.md     # Human-readable summary
├── context/                        # Old system (kept for reference)
│   ├── start_and_export.sh       # NEW: Wrapper script
│   ├── start_logged_session.sh    # OLD: TUI capture (deprecated)
│   ├── extract_conversation.py   # OLD: Parser (no longer needed)
│   └── raw-*.log                 # OLD: Terminal captures
└── export_current_session.sh       # NEW: Export without restart
```

## Session Export Format

### JSON Export
Complete session data including:
- All user messages
- All assistant responses
- Tool calls and outputs
- File edits
- Session metadata

Can be imported with:
```bash
opencode import session-<id>.json
```

### Markdown Summary
Quick reference including:
- Session ID and title
- Date/time
- Working directory
- File locations
- Import instructions

## Usage Examples

### Normal workflow with auto-export
```bash
# Start session
~/AI/context/start_and_export.sh

# Work in opencode normally...

# Exit opencode (Ctrl+C or `exit` in command palette)

# Session automatically exports to ~/AI/sessions/2026-01-04/
```

### Export after the fact
```bash
# Already used opencode, want to save session
~/AI/export_current_session.sh
```

### Import a session
```bash
cd ~/AI/sessions/2026-01-04/
opencode import session-ses_xxx.json
```

## Legacy System

The old system (`start_logged_session*.sh` + `extract_conversation.py`) is preserved but **deprecated**. It attempted to:
1. Capture terminal output with `script` command
2. Remove TUI artifacts
3. Parse conversation from fragmented output

This approach was fragile and produced imperfect results. The new export-based system is cleaner and more reliable.

## Comparison

| Feature | Old (Terminal Capture) | New (Export) |
|---------|----------------------|-------------|
| Data Quality | Fragmented, messy | Clean, complete |
| Artifacts | ANSI codes, TUI render | None |
| Parsing Required | Yes, complex | No |
| Importable | No | Yes |
| Maintenance | High | Low |
| Reliability | Low | High |

## Recommendation

**Use the new export system:**
- `~/AI/context/start_and_export.sh` for normal sessions
- `~/AI/export_current_session.sh` for quick exports

The old system is kept for reference but should not be used going forward.
