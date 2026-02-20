#!/bin/bash
# Quick status check for AI initialization

echo "🤖 AI Instance Status Check"
echo "============================"
echo ""

# Check if startup protocol was run
if [ -f "$HOME/.ai_startup_complete" ]; then
    STARTUP_TIME=$(stat -c %y "$HOME/.ai_startup_complete" 2>/dev/null | cut -d'.' -f1)
    echo "✅ Startup protocol last run: $STARTUP_TIME"
else
    echo "❌ Startup protocol NOT RUN YET"
    echo "   Run: ~/AI/startup-protocol.sh"
fi

echo ""
echo "📚 Skills Available:"
if [ -d "$HOME/.claude/skills" ]; then
    ls -1 "$HOME/.claude/skills" 2>/dev/null | while read skill; do
        if [ -f "$HOME/.claude/skills/$skill/SKILL.md" ]; then
            echo "   • $skill"
        fi
    done
else
    echo "   (No skills directory found)"
fi

echo ""
echo "💬 Recent Conversations:"
CONVO_DIR="$HOME/AI/convo"
if [ -d "$CONVO_DIR" ]; then
    find "$CONVO_DIR" -name "*.md" -type f -printf '%T@ %p\n' 2>/dev/null | \
        sort -rn | head -3 | while read timestamp file; do
        filename=$(basename "$file")
        date_str=$(date -d "@$timestamp" "+%Y-%m-%d %H:%M" 2>/dev/null)
        echo "   • $filename ($date_str)"
    done
else
    echo "   (No conversations found)"
fi

echo ""
echo "📋 Next Steps:"
echo "   1. Run ~/AI/startup-protocol.sh if not done"
echo "   2. Load relevant skill for your task"
echo "   3. Read STARTUP_CHECKLIST.md"
echo "   4. Check recent conversation history"
echo ""
