#!/bin/bash
# Migration script: Migrate existing sessions to new group structure
# Run this once to populate groups with existing sessions

CONVO_DIR=~/AI/convo
GROUPS_DIR=$CONVO_DIR/groups
INDEX_FILE=$CONVO_DIR/index.md

echo "=========================================="
echo "Migrating Existing Sessions to Groups"
echo "=========================================="
echo ""

# Process each dated folder
for DATED_DIR in "$CONVO_DIR"/[0-9]*; do
    if [ ! -d "$DATED_DIR" ]; then
        continue
    fi
    
    DATE_FOLDER=$(basename "$DATED_DIR")
    echo "Processing folder: $DATE_FOLDER"
    
    # Process each session file in the folder
    for SESSION_FILE in "$DATED_DIR"/session*.md; do
        if [ ! -f "$SESSION_FILE" ]; then
            continue
        fi
        
        SESSION_NAME=$(basename "$SESSION_FILE")
        SESSION_BASE="${SESSION_NAME%.md}"
        
        # Skip if already has a summary (already migrated)
        if [ -f "$DATED_DIR/$SESSION_BASE.summary" ]; then
            echo "  - Skipping $SESSION_NAME (already migrated)"
            continue
        fi
        
        echo "  Processing: $SESSION_NAME"
        
        # Detect groups based on keywords
        DETECTED_GROUPS=""
        
        if grep -qi -E "(ai|ollama|llama|opencode|model|gpt|claude|local.*model)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS ai"
        fi
        
        if grep -qi -E "(work|task|project|job|client)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS work"
        fi
        
        if grep -qi -E "(hyprland|waybar|omarchy|window|monitor|display|gpu|driver)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS computer"
        fi
        
        if grep -qi -E "(wifi|network|vpn|ethernet|internet)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS network"
        fi
        
        if grep -qi -E "(code|program|develop|git|repo|terminal|shell)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS development"
        fi
        
        if grep -qi -E "(photo|video|music|media|image|picture)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS media"
        fi
        
        if grep -qi -E "(productivity|note|todo|workflow|organize)" "$SESSION_FILE"; then
            DETECTED_GROUPS="$DETECTED_GROUPS productivity"
        fi
        
        # If no specific groups detected, put in general
        if [ -z "$DETECTED_GROUPS" ]; then
            DETECTED_GROUPS="general"
        fi
        
        # Copy to each detected group
        for GROUP in $DETECTED_GROUPS; do
            if [ -f "$GROUPS_DIR/$GROUP.md" ]; then
                cp "$SESSION_FILE" "$GROUPS_DIR/"
                echo "    ✓ Copied to group: $GROUP"
            fi
        done
        
        # Create summary
        SUMMARY_FILE="$DATED_DIR/$SESSION_BASE.summary"
        
        # Extract first user message
        FIRST_MSG=$(sed -n '/^## User$/,/^## /p' "$SESSION_FILE" | tail -n +2 | head -20 | tr '\n' ' ' | sed 's/##.*//g' | cut -c1-300)
        
        # Get session date
        SESSION_DATE=$(grep -m1 "Created:" "$SESSION_FILE" | sed 's/.*Created: *//' | cut -d',' -f1)
        if [ -z "$SESSION_DATE" ]; then
            SESSION_DATE="$DATE_FOLDER"
        fi
        
        # Count exchanges
        EXCHANGE_COUNT=$(grep -c "^## User" "$SESSION_FILE")
        
        # Write summary
        cat > "$SUMMARY_FILE" << EOF
# Session Summary: $SESSION_BASE

**Date:** $SESSION_DATE
**Groups:** $DETECTED_GROUPS
**Exchanges:** $EXCHANGE_COUNT

---

## First User Message
$FIRST_MSG...

---

## Summary
(Add detailed summary here after reviewing conversation)

EOF
        echo "    ✓ Created summary"
        
        # Add to index
        INDEX_LINE="$SESSION_DATE | $DETECTED_GROUPS | $FIRST_MSG"
        
        # Check if already in index
        if ! grep -q "$SESSION_BASE" "$INDEX_FILE" 2>/dev/null; then
            TEMP_INDEX=$(mktemp)
            echo "$INDEX_LINE" > "$TEMP_INDEX"
            echo "" >> "$TEMP_INDEX"
            cat "$INDEX_FILE" >> "$TEMP_INDEX"
            mv "$TEMP_INDEX" "$INDEX_FILE"
            echo "    ✓ Added to index"
        fi
        
        echo ""
    done
done

echo "=========================================="
echo "Migration Complete!"
echo "=========================================="
