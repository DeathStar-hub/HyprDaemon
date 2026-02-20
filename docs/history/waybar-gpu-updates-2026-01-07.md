# Waybar GPU Sparkline - 2026-01-07 Updates

**File**: `~/.config/waybar/scripts/gpu-spark.sh`
**Updated**: 2026-01-07

---

## Changes Made

### 1. Added GPU Name to Tooltip
**Before**:
```json
{"text":"📊 ▄▅▃▆","tooltip":"GPU: 77% | 817 MHz"}
```

**After**:
```json
{"text":"📊 ▄▅▃▆","tooltip":"GPU: Intel HD Graphics 530\nLoad: 69% | 733 MHz"}
```

**Implementation**:
- Added `GPU_NAME="Intel HD Graphics 530"` variable
- Updated tooltip format to show GPU name on first line
- Shows load percentage and frequency on second line

---

### 2. Removed CPU Sparkline Background

**Before**:
- CPU sparkline had background: `rgba(40, 42, 54, 0.6)`
- Frosted glass effect with border-radius

**After**:
- CPU sparkline now transparent (no background)
- Matches GPU sparkline appearance
- Clean, minimal look

**Implementation**:
- Removed `#custom-cpu-spark` from CSS rule in `style.css` (line 24)
- Rule now only applies to `#clock` and `#temperature`

---

## GPU Detection

### Current System
- **GPU**: Intel HD Graphics 530
- **Path**: `/sys/devices/pci0000:00/0000:00:02.0/drm/card2/`
- **Type**: Integrated graphics
- **Monitoring**: Frequency-based load calculation

### GPU Names Supported
The script currently hardcodes GPU name. To support different GPUs, modify the script:

**Intel HD Graphics**:
```bash
GPU_NAME="Intel HD Graphics 530"
```

**NVIDIA GPUs**:
```bash
GPU_NAME=$(nvidia-smi --query-gpu=name --format=csv,noheader | head -1)
```

**AMD Radeon**:
```bash
GPU_NAME=$(lspci | grep -i vga | grep -o 'AMD Radeon.*' | head -1)
```

---

## Sparkline Consistency

Both CPU and GPU sparklines now have:
- ✅ No background (transparent)
- ✅ Same font: FiraCode Nerd Font, monospace
- ✅ Same font-size: 13px
- ✅ Same update interval: 2 seconds
- ✅ Same icon style: 📊 (chart/graph)

**CPU Sparkline**:
```
▅▆▇▅ ▄▂▃▁
Usage (top) + Frequency (bottom)
```

**GPU Sparkline**:
```
📊 ▄▅▃▆
Load percentage with icon
```

---

## Tooltip Format Comparison

### CPU Sparkline Tooltip
```
CPU: 45% | Freq: 2400 MHz
```

### GPU Sparkline Tooltip (NEW)
```
GPU: Intel HD Graphics 530
Load: 69% | 733 MHz
```

---

## Testing

```bash
# Test GPU script
~/.config/waybar/scripts/gpu-spark.sh

# Expected output:
# {"text":"📊 ▆▆▆▅","tooltip":"GPU: Intel HD Graphics 530\nLoad: 69% | 733 MHz"}

# Restart waybar
pkill waybar && waybar &
```

---

## Customization

### Change GPU Name
Edit `~/AI/config/waybar/scripts/gpu-spark.sh`:
```bash
# Change line ~31
GPU_NAME="Your GPU Name Here"
```

### Add Background Back to CPU
Edit `~/AI/config/waybar/style.css`:
```css
/* Line 24 - Add #custom-cpu-spark back */
#clock, #custom-cpu-spark, #temperature {
    background: rgba(40, 42, 54, 0.6);
    border-radius: 8px;
    padding: 0 8px;
    margin: 0 4px;
}
```

### Change GPU Icon
Edit `~/AI/config/waybar/scripts/gpu-spark.sh`:
```bash
# Change 📊 to any emoji or character
printf '{"text":"📊 %s",...  # Current
printf '{"text":"💻 %s",...   # Laptop
printf '{"text":"🖥️ %s",...   # Desktop
printf '{"text":"🎮 %s",...   # Controller (old)
```

---

## Files Modified

1. `~/.config/waybar/scripts/gpu-spark.sh`
   - Added GPU_NAME variable
   - Updated tooltip format with GPU name
   - Fixed JSON escaping (changed `\n` to `\\n` for proper JSON)

2. `~/.config/waybar/style.css`
   - Removed #custom-cpu-spark from background rule
   - Added #custom-gpu-spark styling rule
   - Both CPU and GPU sparklines now transparent

3. `~/AI/config/waybar/scripts/gpu-spark.sh`
   - Synced for multi-system deployment

4. `~/AI/config/waybar/style.css`
   - Synced for multi-system deployment

---

## Troubleshooting

### GPU Not Showing
**Issue**: Waybar showing "Error parsing JSON" for gpu-spark module

**Cause**: JSON tooltip contained unescaped newline character `\n`

**Fix**: Change `\n` to `\\n` in printf statement:
```bash
# Before (incorrect)
printf '{"tooltip":"GPU: %s\nLoad: %d%%"}' "$NAME" "$LOAD"

# After (correct)
printf '{"tooltip":"GPU: %s\\nLoad: %d%%"}' "$NAME" "$LOAD"
```

**Verification**:
```bash
# Test script output
~/.config/waybar/scripts/gpu-spark.sh

# Check waybar logs for errors
journalctl --user -u waybar -f | grep gpu
```

---

**Status**: ✅ **Complete**
**Ready for sync**: ✅ **YES**
