# GPU Sparkline Fix - 2026-01-07

## Issue
GPU sparkline was not showing in waybar, with JSON parsing errors:
```
[error] custom/gpu-spark: Error parsing JSON: * Line 1, Column 39
  Syntax error: value, object or array expected.
```

## Root Cause
The tooltip in JSON output contained an unescaped newline character `\n` which is not valid JSON.

## Solution
Changed `\n` to `\\n` in the printf statement to properly escape the newline for JSON parsing.

## Files Modified

### `~/.config/waybar/scripts/gpu-spark.sh`

**Before** (Line ~89):
```bash
printf '{"text":"📊 %s","tooltip":"GPU: %s\nLoad: %d%% | %d MHz"}\n' "$spark" "$GPU_NAME" "$GPU_LOAD" "$FREQ_MHZ"
```

**After**:
```bash
printf '{"text":"📊 %s","tooltip":"GPU: %s\\nLoad: %d%% | %d MHz"}\n' "$spark" "$GPU_NAME" "$GPU_LOAD" "$FREQ_MHZ"
```

### `~/.config/waybar/style.css`

Added CSS rule for GPU sparkline to ensure visibility:
```css
#custom-gpu-spark {
    font-family: "FiraCode Nerd Font", monospace;
    font-size: 13px;
    color: #8be9fd;          /* your cyan */
    padding: 0 6px;
    min-width: 60px;
}
```

## Result

GPU sparkline now working correctly:
- ✅ Shows 📊 icon with sparkline
- ✅ Tooltip displays GPU name on first line
- ✅ Tooltip shows load and frequency on second line
- ✅ No JSON parsing errors
- ✅ Matches CPU sparkline appearance (no background)

## Output

```json
{"text":"📊 ▃▃▆▄","tooltip":"GPU: Intel HD Graphics 530\\nLoad: 50% | 533 MHz"}
```

## Verification

```bash
# Test script
~/.config/waybar/scripts/gpu-spark.sh

# Check for errors
journalctl --user -u waybar -f | grep gpu

# Should see no errors now
```

---

**Status**: ✅ **Fixed**
**Date**: 2026-01-07
