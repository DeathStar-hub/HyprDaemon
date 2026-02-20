#!/bin/bash
# Cleanup script: Move session.md files from home to ~/AI/convo/ with date-based folders

echo "=== SESSION CLEANUP ==="

# FIRST: Move any sessions from home to dated folder
SESSION_FILES=$(find "$HOME" -maxdepth 1 -name "session*.md" -type f 2>/dev/null)

if [ -n "$SESSION_FILES" ]; then
    echo "Found session files in home:"
    echo "$SESSION_FILES"
    
    TODAY=$(date +%Y-%m-%d)
    mkdir -p ~/AI/convo/$TODAY
    
    mv "$HOME"/session*.md ~/AI/convo/$TODAY/ 2>/dev/null
    echo "Moved to ~/AI/convo/$TODAY/"
fi

# Track this new session
if [ -f "$HOME/.config/backups/backup-tracker.sh" ]; then
    "$HOME/.config/backups/backup-tracker.sh" --record
fi

# SECOND: Check for sessions not in the index (new sessions that need organizing)
echo ""
echo "=== CHECKING FOR NEW SESSIONS ==="

NEW_SESSIONS=0
for DATED_DIR in ~/AI/convo/[0-9]*; do
    [ -d "$DATED_DIR" ] || continue
    
    for SESSION_FILE in "$DATED_DIR"/session*.md; do
        [ -f "$SESSION_FILE" ] || continue
        
        SESSION_NAME=$(basename "$SESSION_FILE" .md)
        SESSION_ID=$(echo "$SESSION_NAME" | sed 's/session-//')
        
        # Check if session is in the index
        if ! grep -q "$SESSION_ID" ~/AI/convo/index.md 2>/dev/null; then
            echo "NEW: $SESSION_FILE (not in index)"
            NEW_SESSIONS=$((NEW_SESSIONS + 1))
        fi
    done
done

if [ $NEW_SESSIONS -gt 0 ]; then
    echo ""
    echo "⚠️ $NEW_SESSIONS new session(s) need organizing!"
    echo "UNORGANIZED_SESSIONS=1"
else
    echo "All sessions are organized and indexed."
    echo "ALL_SESSIONS_ORGANIZED=1"
fi
