#!/usr/bin/env bash
# ~/.config/waybar/scripts/gpu-spark.sh
# Outputs JSON:  {"text":"🎮 ▅▄▃▂","tooltip":"GPU: 50% | Freq: 1400 MHz"}

HISTFILE="/tmp/waybar_gpu_hist_$USER"
MAX=4                     # how many points to keep (width of the sparkline)

# ---- read GPU frequency (Intel HD Graphics) ---------------------------------
FREQ_MHZ=0
GPU_LOAD=0
GPU_NAME="Intel HD Graphics 530"

# Try different paths for GPU frequency
if [[ -f "/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt_cur_freq_mhz" ]]; then
    FREQ_MHZ=$(cat "/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt_cur_freq_mhz" 2>/dev/null || echo "0")
elif [[ -f "/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt/gt0/rps_cur_freq_mhz" ]]; then
    FREQ_MHZ=$(cat "/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt/gt0/rps_cur_freq_mhz" 2>/dev/null || echo "0")
elif [[ -f "/sys/class/drm/card2/device/gt_cur_freq_mhz" ]]; then
    FREQ_MHZ=$(cat "/sys/class/drm/card2/device/gt_cur_freq_mhz" 2>/dev/null || echo "0")
fi

# ---- calculate GPU load percentage -----------------------------------------
# Use frequency ratio as load indicator (current / max)
if (( FREQ_MHZ > 0 )); then
    # Try to get max frequency
    MAX_FREQ=0
    if [[ -f "/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt/gt0/rps_max_freq_mhz" ]]; then
        MAX_FREQ=$(cat "/sys/devices/pci0000:00/0000:00:02.0/drm/card2/gt/gt0/rps_max_freq_mhz" 2>/dev/null || echo "0")
    elif [[ -f "/sys/class/drm/card2/device/gt_max_freq_mhz" ]]; then
        MAX_FREQ=$(cat "/sys/class/drm/card2/device/gt_max_freq_mhz" 2>/dev/null || echo "0")
    fi

    if (( MAX_FREQ > 0 )); then
        GPU_LOAD=$(( FREQ_MHZ * 100 / MAX_FREQ ))
    else
        # Fallback: assume max around 1200 MHz for Intel HD Graphics 530
        GPU_LOAD=$(( FREQ_MHZ * 100 / 1200 ))
    fi
    (( GPU_LOAD > 100 )) && GPU_LOAD=100
fi

# ---- append to rolling history ---------------------------------------------
echo "$GPU_LOAD" >> "$HISTFILE"
# keep only the last $MAX entries
tail -n "$MAX" "$HISTFILE" > "${HISTFILE}.tmp" && mv "${HISTFILE}.tmp" "$HISTFILE"

# ---- build sparkline (8-level unicode blocks) -------------------------------
mapfile -t vals < "$HISTFILE"
spark=""
for v in "${vals[@]}"; do
    # 0-100% → 0-7
    idx=$(( v * 7 / 100 ))
    case $idx in
        0) c="▁" ;; 1) c="▂" ;; 2) c="▃" ;; 3) c="▄" ;;
        4) c="▅" ;; 5) c="▆" ;; 6) c="▇" ;; *) c="█" ;;
    esac
    spark+="$c"
done

# ---- JSON output ------------------------------------------------------------
# GPU type detection and icon
GPU_ICON="D"  # Default to Dedicated (most systems have discrete GPU)
# Check for integrated GPU (Intel)
if [[ -d "/sys/class/drm/card0/device/i915" ]] || [[ -d "/sys/module/i915" ]]; then
    GPU_ICON="I"  # Intel Integrated GPU
fi

if (( FREQ_MHZ > 0 )); then
    printf '{"text":"%s %s","tooltip":"GPU: %s\\nLoad: %d%% | %d MHz"}\n' "$GPU_ICON" "$spark" "$GPU_NAME" "$GPU_LOAD" "$FREQ_MHZ"
else
    printf '{"text":"%s","tooltip":"GPU: Checking..."}\n' "$GPU_ICON"
fi
