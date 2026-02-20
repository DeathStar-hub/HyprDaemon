#!/bin/bash
# AI Startup Protocol - Run this at the beginning of EVERY new session
# This ensures all mandatory initialization steps are completed before task execution

echo "=========================================="
echo "🤖 AI INSTANCE STARTUP PROTOCOL"
echo "=========================================="
echo ""
echo "🐢 QUALITY OVER SPEED PRINCIPLE 🐢"
echo "Take the extra 60 seconds. Get it RIGHT, not fast."
echo "Fast + Wrong = Waste time | Slow + Correct = Efficient"
echo "=========================================="
echo ""

# Track completion
STEPS_COMPLETED=0
TOTAL_STEPS=8

# Step 1: Cleanup
echo "[1/$TOTAL_STEPS] Running cleanup script..."
if ~/AI/cleanup-sessions.sh; then
    echo "   ✅ Cleanup completed"
    ((STEPS_COMPLETED++))
else
    echo "   ⚠️  Cleanup script not found or failed"
fi

# Step 2: Check for skill files that need to be loaded
echo ""
echo "[2/$TOTAL_STEPS] Loading ALL relevant skills..."
echo "   ⚠️  DO NOT SKIP - Even 'simple' questions need full context!"
SKILLS_DIR="$HOME/.claude/skills"
if [ -d "$SKILLS_DIR" ]; then
    SKILL_COUNT=$(find "$SKILLS_DIR" -name "*.md" -type f 2>/dev/null | wc -l)
    if [ $SKILL_COUNT -gt 0 ]; then
        echo "   📚 Found $SKILL_COUNT skill files:"
        find "$SKILLS_DIR" -name "*.md" -type f -exec basename {} \; | sed 's/^/      - /'
        echo "   ⚠️  REMEMBER: Load relevant skills BEFORE starting tasks!"
        ((STEPS_COMPLETED++))
    else
        echo "   ℹ️  No skill files found"
        ((STEPS_COMPLETED++))
    fi
else
    echo "   ℹ️  Skills directory not found"
    ((STEPS_COMPLETED++))
fi

# Step 3: Read AI system constraints
echo ""
echo "[3/$TOTAL_STEPS] Loading AI system constraints..."
if [ -f "$HOME/AI/AI-SYSTEM-CONSTRAINTS.md" ]; then
    echo "   ✅ AI-SYSTEM-CONSTRAINTS.md found"
    echo "   📋 Key constraints loaded (read full file for details)"
    ((STEPS_COMPLETED++))
else
    echo "   ⚠️  AI-SYSTEM-CONSTRAINTS.md not found"
fi

# Step 4: Read README
echo ""
echo "[4/$TOTAL_STEPS] Loading AI README..."
if [ -f "$HOME/AI/README.md" ]; then
    echo "   ✅ README.md found"
    ((STEPS_COMPLETED++))
else
    echo "   ⚠️  README.md not found"
fi

# Step 5: Check for recent conversation context
echo ""
echo "[5/$TOTAL_STEPS] Checking conversation history..."
CONVO_DIR="$HOME/AI/convo"
if [ -d "$CONVO_DIR" ]; then
    RECENT_CONVO=$(find "$CONVO_DIR" -name "*.md" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)
    if [ -n "$RECENT_CONVO" ]; then
        echo "   ✅ Most recent conversation: $(basename "$RECENT_CONVO")"
        echo "   💡 TIP: Read last 50-100 lines for continuity"
        ((STEPS_COMPLETED++))
    else
        echo "   ℹ️  No conversation files found"
        ((STEPS_COMPLETED++))
    fi
else
    echo "   ⚠️  Conversation directory not found"
fi

# Step 6: Load Omarchy skill (CRITICAL)
echo ""
echo "[6/$TOTAL_STEPS] Loading Omarchy skill (CRITICAL for Hyprland/Waybar)..."
OMARCHY_SKILL="$HOME/.local/share/omarchy/default/omarchy-skill/SKILL.md"
if [ -f "$OMARCHY_SKILL" ]; then
    echo "   ✅ Omarchy skill found at:"
    echo "      $OMARCHY_SKILL"
    echo ""
    echo "   🔑 KEY REMINDERS FROM SKILL:"
    echo "      • NEVER edit ~/.local/share/omarchy/ (package-managed)"
    echo "      • ALWAYS edit ~/.config/ for customizations"
    echo "      • Use 'hyprctl configerrors' after Hyprland updates"
    echo "      • Omarchy has ~145 commands (omarchy-*)"
    ((STEPS_COMPLETED++))
else
    echo "   ⚠️  Omarchy skill not found - may not be an Omarchy system"
    ((STEPS_COMPLETED++))
fi

# Step 7: Check current project context
echo ""
echo "[7/$TOTAL_STEPS] Checking current project context..."
if [ -f "$HOME/AI/PROJECT_PROGRESS.md" ]; then
    echo "   ✅ PROJECT_PROGRESS.md found"
    echo "   💡 Check this file for ongoing work and current status"
    ((STEPS_COMPLETED++))
else
    echo "   ℹ️  No PROJECT_PROGRESS.md found"
    ((STEPS_COMPLETED++))
fi

# Step 8: Final checklist
echo ""
echo "[8/$TOTAL_STEPS] Final pre-flight checklist..."
echo "   ☐ Loaded all relevant skills for the task?"
echo "   ☐ Checked conversation history for continuity?"
echo "   ☐ Backed up any files before editing?"
echo "   ☐ Read documentation before making changes?"
((STEPS_COMPLETED++))

# Mark startup as complete
touch "$HOME/.ai_startup_complete"

# Create fresh backups of critical configs
echo ""
echo "🛡️  Creating safety backups of critical configs..."
~/AI/backup-critical-configs.sh > /dev/null 2>&1 && echo "   ✅ Critical configs backed up to ~/.config/backups/"

# Summary
echo ""
echo "=========================================="
echo "📊 STARTUP COMPLETE: $STEPS_COMPLETED/$TOTAL_STEPS steps verified"
echo "=========================================="
echo ""
echo "🎯 READY TO ASSIST"
echo ""
echo "💡 QUICK REFERENCE:"
echo "   • Check status: ~/AI/status.sh"
echo "   • Hyprland errors: hyprctl configerrors"
echo "   • Config locations: ~/.config/"
echo "   • Skill command: skill <name>"
echo "   • Backup command: cp file file.bak.\$(date +%s)"
echo ""
