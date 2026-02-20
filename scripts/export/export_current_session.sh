#!/usr/bin/env bash

set -euo pipefail

SESSION_STORAGE="$HOME/.local/share/opencode/storage/session/global"
SESSIONS_DIR="$HOME/AI/sessions"
DATE_DIR="$SESSIONS_DIR/$(date +%Y-%m-%d)"

mkdir -p "$DATE_DIR"

# Check for --list flag
if [ "${1:-}" = "--list" ]; then
  echo
  echo "========================================"
  echo " Available Opencode Sessions"
  echo "========================================"
  echo

  SESSIONS=$(ls -t "$SESSION_STORAGE"/ses_*.json 2>/dev/null | tac || true)

  if [ -z "$SESSIONS" ]; then
    echo "No sessions found"
    exit 1
  fi

  # Count total sessions and start from that number
  TOTAL=$(echo "$SESSIONS" | wc -w)
  INDEX=$TOTAL
  for SESSION_FILE in $SESSIONS; do
    SESSION_ID=$(basename "$SESSION_FILE" .json)
    TITLE=$(jq -r '.title // "Untitled Session"' "$SESSION_FILE")
    UPDATED=$(jq -r '.time.updated // 0' "$SESSION_FILE")

    # Convert ms timestamp to date
    if [ "$UPDATED" != "0" ]; then
      UPDATED_DATE=$(date -d "@$((UPDATED / 1000))" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "Unknown")
    else
      UPDATED_DATE="Unknown"
    fi

    printf "%2d) %s\n" "$INDEX" "$SESSION_ID"
    echo "    Title: $TITLE"
    echo "    Updated: $UPDATED_DATE"
    echo "    File: $SESSION_FILE"
    echo
    INDEX=$((INDEX - 1))
  done

  echo "========================================"
  echo "Usage: $0 [session-id | --list | --recent | --current | --interactive]"
  echo "  No argument: Export most recent session"
  echo "  session-id: Export specific session"
  echo "  --list: List all sessions"
  echo "  --recent: Show only recent sessions (last 10)"
  echo "  --current: Export current session (most recent)"
  echo "  --interactive/-i: Interactive session selection (fzf)"
  echo "========================================"
  exit 0
fi

# Check for --current flag (export most recent session)
if [ "${1:-}" = "--current" ]; then
  # Auto-detect most recent session
  SESSION_FILE=$(ls -t "$SESSION_STORAGE"/ses_*.json 2>/dev/null | head -1)

  if [ -z "$SESSION_FILE" ]; then
    echo "Error: No sessions found in $SESSION_STORAGE"
    echo "Run '$0 --list' to see available sessions"
    exit 1
  fi

  SESSION_ID=$(basename "$SESSION_FILE" .json)

  echo "========================================"
  echo " Current Session"
  echo "========================================"
  echo "Session ID: $SESSION_ID"

  # Read and display session info
  TITLE=$(jq -r '.title // "Untitled Session"' "$SESSION_FILE")
  UPDATED=$(jq -r '.time.updated // 0' "$SESSION_FILE")

  if [ "$UPDATED" != "0" ]; then
    UPDATED_DATE=$(date -d "@$((UPDATED / 1000))" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "Unknown")
  else
    UPDATED_DATE="Unknown"
  fi

  echo "Title: $TITLE"
  echo "Updated: $UPDATED_DATE"
  echo "========================================"
  echo
  echo "Exporting current session..."

  # Export session to JSON
  JSON_OUTPUT="$DATE_DIR/session-$SESSION_ID.json"
  opencode export "$SESSION_ID" > "$JSON_OUTPUT" 2>&1

  if [ $? -eq 0 ] && [ -s "$JSON_OUTPUT" ]; then
    SIZE=$(du -h "$JSON_OUTPUT" | cut -f1)
    echo "Export complete: $SIZE"
    echo "JSON: $JSON_OUTPUT"
  else
    echo "Export failed or empty"
    exit 1
  fi

  # Create markdown summary
  TIMESTAMP=$(date +%H-%M-%S)
  MD_OUTPUT="$DATE_DIR/session-$TIMESTAMP.md"

  CURRENT_DATE=$(date +%Y-%m-%d)
  CURRENT_TIME=$(date +%H:%M:%S)

  echo "Creating markdown summary..."

  DIRECTORY=$(jq -r '.directory // "N/A"' "$SESSION_FILE")
  PROJECT=$(jq -r '.projectID // "N/A"' "$SESSION_FILE")
  CREATED_MS=$(jq -r '.time.created // 0' "$SESSION_FILE")
  UPDATED_MS=$(jq -r '.time.updated // 0' "$SESSION_FILE")

  {
    echo "# Opencode Session Export"
    echo ""
    echo "**Session ID:** $SESSION_ID"
    echo "**Date:** $CURRENT_DATE"
    echo "**Time:** $CURRENT_TIME"
    echo "**Title:** $TITLE"
    echo ""
    echo "---"
    echo ""
    echo "## Session Info"
    echo "- **Directory:** $DIRECTORY"
    echo "- **Project:** $PROJECT"
    echo "- **Created:** $CREATED_MS (ms since epoch)"
    echo "- **Updated:** $UPDATED_MS (ms since epoch)"
    echo ""
    echo "---"
    echo ""
    echo "## Export Files"
    echo "- **Full JSON:** session-$SESSION_ID.json - Complete session with all messages and tool calls"
    echo "- **This Markdown:** session-$TIMESTAMP.md - Session summary and metadata"
    echo ""
    echo "---"
    echo ""
    echo "## How to Import This Session"
    echo '```bash'
    echo "# From: sessions directory"
    echo "opencode import session-$SESSION_ID.json"
    echo '```'
    echo ""
    echo "---"
    echo ""
    echo "## Exported On"
    echo "$CURRENT_DATE at $CURRENT_TIME"
    echo ""
  } > "$MD_OUTPUT"

  echo "Markdown summary created: $MD_OUTPUT"
  echo "========================================"
  echo "Export Complete"
  echo "========================================"
  echo "Session ID: $SESSION_ID"
  echo "JSON: $JSON_OUTPUT"
  echo "Markdown: $MD_OUTPUT"
  echo "========================================"
  exit 0
fi

# Check for --recent flag
if [ "${1:-}" = "--recent" ]; then
  echo
  echo "========================================"
  echo " Recent Sessions (Last 10)"
  echo "========================================"
  echo

  SESSIONS=$(ls -t "$SESSION_STORAGE"/ses_*.json 2>/dev/null | head -10 | tac || true)

  if [ -z "$SESSIONS" ]; then
    echo "No sessions found"
    exit 1
  fi

  # Count total sessions and start from that number
  TOTAL=$(echo "$SESSIONS" | wc -w)
  INDEX=$TOTAL
  for SESSION_FILE in $SESSIONS; do
    SESSION_ID=$(basename "$SESSION_FILE" .json)
    TITLE=$(jq -r '.title // "Untitled Session"' "$SESSION_FILE")
    UPDATED=$(jq -r '.time.updated // 0' "$SESSION_FILE")

    # Convert ms timestamp to date
    if [ "$UPDATED" != "0" ]; then
      UPDATED_DATE=$(date -d "@$((UPDATED / 1000))" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "Unknown")
    else
      UPDATED_DATE="Unknown"
    fi

    printf "%2d) %s\n" "$INDEX" "$SESSION_ID"
    echo "    Title: $TITLE"
    echo "    Updated: $UPDATED_DATE"
    echo
    INDEX=$((INDEX - 1))
  done

  echo "========================================"
  echo "Usage: $0 [session-id | --recent | --current]"
  echo "  session-id: Export specific session"
  echo "  --recent: Show only recent sessions (last 10)"
  echo "  --current: Export current session (most recent)"
  echo "========================================"
  exit 0
fi

# Check for --interactive flag
if [ "${1:-}" = "--interactive" ] || [ "${1:-}" = "-i" ]; then
  # Check for fzf
  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: fzf not found. Install with: paru -S fzf"
    echo "Or use --recent to see last 10 sessions"
    exit 1
  fi

  echo "Selecting session..."

  # Format sessions for fzf
  SESSION_ID=$(ls -t "$SESSION_STORAGE"/ses_*.json 2>/dev/null | tac | while read -r SESSION_FILE; do
    SESSION_ID=$(basename "$SESSION_FILE" .json)
    TITLE=$(jq -r '.title // "Untitled Session"' "$SESSION_FILE)
    UPDATED=$(jq -r '.time.updated // 0' "$SESSION_FILE")

    if [ "$UPDATED" != "0" ]; then
      UPDATED_DATE=$(date -d "@$((UPDATED / 1000))" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "Unknown")
    else
      UPDATED_DATE="Unknown"
    fi

    printf "%-40s %-50s %s\n" "$SESSION_ID" "$TITLE" "$UPDATED_DATE"
  done | fzf --header="Select session to export" --prompt="> " --height=15 | awk '{print $1}')

  if [ -z "$SESSION_ID" ]; then
    echo "No session selected"
    exit 0
  fi

  SESSION_FILE="$SESSION_STORAGE/$SESSION_ID.json"
else
  # Determine which session to export
  SESSION_ID="${1:-}"

  if [ -n "$SESSION_ID" ]; then
    # User provided specific session ID
    SESSION_FILE="$SESSION_STORAGE/$SESSION_ID.json"
    if [ ! -f "$SESSION_FILE" ]; then
      echo "Error: Session not found: $SESSION_ID"
      echo "Run '$0 --list' to see available sessions"
      echo "Run '$0 --recent' to see recent sessions"
      echo "Run '$0 --current' to export current session"
      echo "Run '$0 --interactive' to select interactively"
      exit 1
    fi
  else
    # Auto-detect most recent session
    SESSION_FILE=$(ls -t "$SESSION_STORAGE"/ses_*.json 2>/dev/null | head -1)

    if [ -z "$SESSION_FILE" ]; then
      echo "Error: No sessions found in $SESSION_STORAGE"
      echo "Run '$0 --list' to see available sessions"
      exit 1
    fi

    SESSION_ID=$(basename "$SESSION_FILE" .json)
  fi
fi

echo "========================================"
echo " Opencode Session Export"
echo "========================================"
echo "Session ID: $SESSION_ID"
echo "Date: $(date +%Y-%m-%d)"
echo "Output directory: $DATE_DIR"
echo "========================================"
echo

# Read session metadata
TITLE=$(jq -r '.title // "Untitled Session"' "$SESSION_FILE")
DIRECTORY=$(jq -r '.directory // "N/A"' "$SESSION_FILE")
PROJECT=$(jq -r '.projectID // "N/A"' "$SESSION_FILE")
CREATED_MS=$(jq -r '.time.created // 0' "$SESSION_FILE")
UPDATED_MS=$(jq -r '.time.updated // 0' "$SESSION_FILE")

# Export session to JSON
JSON_OUTPUT="$DATE_DIR/session-$SESSION_ID.json"
echo "Exporting session to JSON..."
opencode export "$SESSION_ID" > "$JSON_OUTPUT" 2>&1

if [ $? -eq 0 ] && [ -s "$JSON_OUTPUT" ]; then
  SIZE=$(du -h "$JSON_OUTPUT" | cut -f1)
  echo "JSON export complete: $SIZE"
else
  echo "JSON export failed or empty"
fi

# Create markdown summary
TIMESTAMP=$(date +%H-%M-%S)
MD_OUTPUT="$DATE_DIR/session-$TIMESTAMP.md"
echo "Creating markdown summary..."

CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_TIME=$(date +%H:%M:%S)

{
  echo "# Opencode Session Export" > "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "**Session ID:** $SESSION_ID" >> "$MD_OUTPUT"
  echo "**Date:** $CURRENT_DATE" >> "$MD_OUTPUT"
  echo "**Time:** $CURRENT_TIME" >> "$MD_OUTPUT"
  echo "**Title:** $TITLE" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "---" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "## Session Info" >> "$MD_OUTPUT"
  echo "- **Directory:** $DIRECTORY" >> "$MD_OUTPUT"
  echo "- **Project:** $PROJECT" >> "$MD_OUTPUT"
  echo "- **Created:** $CREATED_MS (ms since epoch)" >> "$MD_OUTPUT"
  echo "- **Updated:** $UPDATED_MS (ms since epoch)" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "---" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "## Export Files" >> "$MD_OUTPUT"
  echo "- **Full JSON:** session-$SESSION_ID.json - Complete session with all messages and tool calls" >> "$MD_OUTPUT"
  echo "- **This Markdown:** session-$TIMESTAMP.md - Session summary and metadata" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "---" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "## How to Import This Session" >> "$MD_OUTPUT"
  echo '```bash' >> "$MD_OUTPUT"
  echo "# From: sessions directory" >> "$MD_OUTPUT"
  echo "opencode import session-$SESSION_ID.json" >> "$MD_OUTPUT"
  echo '```' >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "---" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"
  echo "## Exported On" >> "$MD_OUTPUT"
  echo "$CURRENT_DATE at $CURRENT_TIME" >> "$MD_OUTPUT"
  echo "" >> "$MD_OUTPUT"

echo "Markdown summary created: $MD_OUTPUT"
echo
echo "========================================"
echo "Export Complete"
echo "========================================"
echo "Session ID: $SESSION_ID"
echo "JSON: $JSON_OUTPUT"
echo "Markdown: $MD_OUTPUT"
echo "========================================"
