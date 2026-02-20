#!/bin/bash
# Clean Log Viewer - Filters out RE2 regex errors
# Use this instead of journalctl to view logs without error spam

if [ $# -eq 0 ]; then
    echo "📋 Usage: clean-logs [journalctl-options]"
    echo ""
    echo "Examples:"
    echo "  clean-logs --user -f"
    echo "  clean-logs --user --since '10 minutes ago'"
    echo "  clean-logs --user -u xdg-desktop-portal-hyprland"
    echo ""
    echo "This command filters out annoying RE2 regex errors while showing all other logs."
    echo ""
    exit 0
fi

# Run journalctl but filter out RE2 regex errors
journalctl "$@" | grep -v "Invalid RE2.*unexpected.*wants to \[open|save\]"
