# Waybar Reload Instructions

To reload Waybar after config changes without duplicating bars:

1. Kill all current Waybar instances:  
   `pkill waybar`

2. Start a new instance in the background:  
   `waybar &`

**Important:** Always use `&` when starting Waybar manually, as running it in foreground may cause issues in Hyprland. Avoid running `waybar` without `&` to prevent multiple bars appearing on screen.

This ensures only one Waybar instance runs at a time.