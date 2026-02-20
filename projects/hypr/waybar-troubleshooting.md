# Waybar Configuration Troubleshooting

## Quick Setup (Turnkey)

For a complete working waybar setup, copy the entire configuration from AI:

```bash
# Copy the complete working configuration
cp -r ~/AI/config/waybar/* ~/.config/waybar/
cp ~/AI/config/waybar/config.jsonc ~/.config/waybar/config.jsonc

# Restart waybar
pkill waybar && waybar &
```

## If Weather Widget Not Working

### Symptoms
- Weather shows "N/A" or doesn't appear
- Temperature sensor shows wrong values
- Click actions don't work

### Quick Fix Checklist

1. **Verify Correct Files Are Installed**
   ```bash
   # Should return the working config with height: 23
   grep -n "height" ~/.config/waybar/config.jsonc
   
   # Should return the complete weather script
   grep -n "weather-widget-complete" ~/.config/waybar/scripts/weather.sh
   ```

2. **Check Weather Script Permissions**
   ```bash
   chmod +x ~/.config/waybar/scripts/weather.sh
   ```

3. **Test Weather Script Manually**
   ```bash
   ~/.config/waybar/scripts/weather.sh
   # Should return JSON like: {"text":"☀️ -5°C","tooltip":"..."}
   ```

4. **Verify Dependencies**
   ```bash
   which curl jq  # Both should be installed
   ```

5. **Check Temperature Sensor Path**
   ```bash
   # Find your correct hwmon path
   ls /sys/class/hwmon/hwmon*/temp1_input
   # Update config.jsonc with correct path (usually hwmon7, hwmon3, etc.)
   ```

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| Weather shows "N/A" | Wrong API or network issue | Test internet connection, check weather script manually |
| Temperature wrong | Wrong hwmon path | Find correct path with `ls /sys/class/hwmon/hwmon*/temp1_input` |
| No click actions | Missing click handlers in config | Ensure weather module has on-click entries |
| Unicode errors | Emoji encoding issues | Use the complete weather script from AI |
| Waybar crashes | JSON syntax error | Run `waybar` in terminal to see error messages |

### Debug Commands

```bash
# Test waybar config syntax
waybar --config ~/.config/waybar/config.jsonc --dry-run

# Check waybar logs
journalctl --user -u waybar -f

# Test weather script with debug
~/.config/waybar/scripts/weather.sh 2>&1 | jq .
```

### File Locations

- **Working Config**: `~/AI/config/waybar/config.jsonc`
- **Working Scripts**: `~/AI/config/waybar/scripts/`
- **Weather Script**: `~/AI/projects/hypr/weather-widget-complete.sh`
- **User Config**: `~/.config/waybar/`

### Important Notes

- Always copy the ENTIRE `scripts/` directory, not individual files
- The working config uses `height: 23` (not 34 or other values)
- Weather updates every 30 minutes (1800 seconds)
- Temperature path varies by system (commonly hwmon7, hwmon3, hwmon1)

## Omarchy Menu (Walker) Troubleshooting

### Symptoms
- Menu appears without rounded corners
- Letters or layout appear out of place in themes menu
- Walker windows don't respond to hyprland window rules

### Quick Fix Steps
1. **Check Walker Theme:**
   - Ensure walker config uses `theme = "omarchy-default"` (not "aetheria")
   - If rounded corners missing, edit `~/.local/share/omarchy/default/walker/themes/omarchy-default/style.css`
   - Add `border-radius: 15px;` to `.box-wrapper` and `border-radius: 10px;` to `.search-container`

2. **Disable Client-Side Decorations:**
   - Add to `~/.config/hypr/hyprland.conf`:
     ```
     windowrulev2 = unset, class:walker
     windowrule = float, class:walker
     windowrule = rounding 15, class:walker
     windowrule = bordersize 4, class:walker
     windowrule = dimaround, class:walker
     windowrule = opaque, class:walker
     ```
   - Reload hyprland: `hyprctl reload`

3. **Restart Walker:**
   - Kill processes: `pkill walker`
   - Test menu again

### Common Issues & Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| No rounded corners | CSD enabled, theme lacks border-radius | Disable CSD in hyprland, add border-radius to theme CSS |
| Layout broken | Theme incompatibility | Switch to "omarchy-default" theme, update omarchy themes |
| Window not floating | Missing hyprland rules | Add float rule for class:walker |
| Theme not loading | Wrong theme path | Check `additional_theme_location` in walker config |

### When to Do This from the Start
If setting up the omarchy menu for the first time or after theme updates, always:
- Ensure walker theme is "omarchy-default"
- Add hyprland window rules for walker
- Edit theme CSS for border-radius if needed
- Test menu appearance before considering setup complete

### Debug Commands
```bash
# Check walker theme
grep "theme" ~/.config/walker/config.toml

# Verify hyprland rules
grep -A5 "class:walker" ~/.config/hypr/hyprland.conf

# Test menu manually
omarchy-menu
```

### Last Resort Reset

If nothing works, reset walker config:

```bash
# Backup current
cp ~/.config/walker/config.toml ~/.config/walker/config.toml.backup

# Copy fresh from AI
cp ~/AI/config/walker/config.toml ~/.config/walker/

# Restart
pkill walker
```

---

### Last Resort Reset

If nothing works, reset completely:

```bash
# Backup current config
mv ~/.config/waybar ~/.config/waybar.backup

# Copy fresh from AI
cp -r ~/AI/config/waybar ~/.config/waybar

# Restart
pkill waybar && waybar &
```

---
*This file addresses common setup issues with the waybar configuration from the AI folder.*