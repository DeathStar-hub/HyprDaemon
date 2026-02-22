## Session: ses_3c18 (2026-02-08)

**Date:** 2026-02-08
**Groups:** computer, development

### Summary
User tried to copy AI folder to USB but it kept hanging due to symbolic links. Found many symlinks in AI folder (especially in config/hypr/shaders/).

### Key Points
- USB copy of AI folder hanging
- Caused by symbolic links in the folder
- Found 50+ symlinks in AI/ (especially shaders)
- Symlinks point to external locations

### Files Identified with Symlinks
- AI-SYSTEM-CONSTRAINTS.md (→ docs/protocol/)
- cleanup-sessions.sh (→ scripts/cleanup/)
- Many Hyprland shaders in config/hypr/shaders/

### Solutions Discussed
- Use `cp -L` to dereference symlinks
- Use `rsync --copy-unsafe-links`
- Archive without symlinks first

### Topics
USB, symlinks, file copy, Hyprland, shaders

### End Context
Q: im trying to copy the AI folder onto a usb but it keeps hanging up , something about sim links
A: Found 50+ symlinks, recommended using cp -L or rsync to handle them
