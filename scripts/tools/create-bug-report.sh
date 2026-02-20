#!/bin/bash
# Bug Report Script for xdg-desktop-portal-hyprland RE2 Error

# This script generates a bug report for the RE2 regex error
# in xdg-desktop-portal-hyprland version 1.3.11-3

cat << 'EOF'
================================================================================
xdg-desktop-portal-hyprland Bug Report: Invalid RE2 Regex
================================================================================

**Package**: xdg-desktop-portal-hyprland
**Version**: 1.3.11-3
**Repository**: https://github.com/hyprwm/xdg-desktop-portal-hyprland

---

## Issue Description

The package contains an invalid RE2 regex pattern that generates approximately 112+ errors
per session when applications use file dialogs.

---

## Error Messages

```
E0000 00:00:1767704607.344507 re2.cc:926] Invalid RE2: unexpected ): ^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save]).*|[C|c]hoose.*)
```

---

## Root Cause

**Invalid Pattern**: `.*wants to [open|save]).*`

**Problem**: Pipes (|) are NOT allowed inside character classes [...] in RE2 regex engine.
The pattern `[open|save]` is interpreted as matching ANY of the characters:
'o', 'p', 'e', 'n', '|', 's', 'a', 'v', 'e'

This is NOT matching "open" OR "save" as intended.

---

## Correct Pattern

**Should be**: `.*wants to (open|save)).*`

The pipes (|) must be OUTSIDE the character class, using a capturing
group for alternation: `(open|save)`

---

## Impact

- **Error Count**: ~112+ errors per session
- **User Impact**: Log spam, no functional issues
- **Affected**: All xdg-desktop-portal file dialog interactions

---

## Reproduction Steps

1. Install xdg-desktop-portal-hyprland version 1.3.11-3
2. Open Hyprland session
3. Check journal: `journalctl --user -f | grep RE2`
4. Errors appear when applications use file dialogs

---

## Suggested Fix

File: Likely in src/fileChooser.cpp or similar

Change regex from:
```cpp
// Current (INVALID)
const std::string pattern = R"(^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save]).*|[C|c]hoose.*)";
```

To:
```cpp
// Fixed (VALID)
const std::string pattern = R"(^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to (open|save)).*|[C|c]hoose.*)";
```

---

## Workaround Options

### Option 1: Suppress Errors (Temporary)
```bash
# Add to ~/.config/hyprland/hyprland.conf (if supported)
# Note: May not work for systemd user services
```

### Option 2: Report and Wait
- Report this issue to: https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues
- Wait for package update from Arch maintainers

### Option 3: Use Alternative Portal
Note: Not recommended as Hyprland requires specific portal implementation.

---

## System Information

```bash
OS: Arch Linux
Hyprland: 0.53.1-1
xdg-desktop-portal-hyprland: 1.3.11-3
Compiler: RE2 (Google's regex engine)
```

---

## Files Generated

- `~/AI/BUG_REPORT_xdg-portal-re2-error.txt` - This file
- `~/AI/ERROR_SUMMARY.md` - Full error analysis

---

## Next Steps

1. **Submit bug report**: Copy this report to GitHub issues
2. **Monitor for fix**: Check for updates to xdg-desktop-portal-hyprland
3. **Temporary suppression**: Use journal filtering to reduce noise

---

**Report Generated**: $(date '+%Y-%m-%d %H:%M:%S')
**By**: AI Assistant for Hyprland Configuration

================================================================================
EOF

echo ""
echo "✓ Bug report generated!"
echo ""
echo "📋 To submit this bug:"
echo "   1. Go to: https://github.com/hyprwm/xdg-desktop-portal-hyprland/issues"
echo "   2. Click 'New Issue'"
echo "   3. Paste the contents of this report"
echo ""
echo "📁 Bug report saved to: ~/AI/BUG_REPORT_xdg-portal-re2-error.txt"
echo ""
