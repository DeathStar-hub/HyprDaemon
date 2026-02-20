#!/usr/bin/env bash
# ~/.config/waybar/scripts/cpu-spark.sh
# Outputs JSON:  {"text":"▁▃▅▇█▇▅▃", "tooltip":"CPU: 23%"}

HISTFILE="/tmp/waybar_cpu_hist_$USER"
HISTFILE_FREQ="/tmp/waybar_cpu_freq_hist_$USER"
MAX=4                     # how many points to keep (width of the sparkline)

# ---- read current CPU stats -------------------------------------------------
read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
TOTAL=$(( user + nice + system + idle + iowait + irq + softirq + steal ))
IDLE=$idle

# ---- read current CPU frequency ---------------------------------------------
FREQ_SUM=0
CORE_COUNT=0
for cpu in /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq; do
    if [[ -f "$cpu" ]]; then
        FREQ_SUM=$(( FREQ_SUM + $(cat "$cpu") ))
        CORE_COUNT=$(( CORE_COUNT + 1 ))
    fi
done
if (( CORE_COUNT > 0 )); then
    AVG_FREQ=$(( FREQ_SUM / CORE_COUNT / 1000 ))  # MHz
else
    AVG_FREQ=0
fi

# ---- load previous values ---------------------------------------------------
if [[ -f "$HISTFILE" ]]; then
    read -r PREV_TOTAL PREV_IDLE < "$HISTFILE"
else
    PREV_TOTAL=$TOTAL
    PREV_IDLE=$IDLE
fi

# ---- store for next run -----------------------------------------------------
printf '%s %s\n' "$TOTAL" "$IDLE" > "$HISTFILE"

# ---- calculate usage --------------------------------------------------------
DIFF_TOTAL=$(( TOTAL - PREV_TOTAL ))
DIFF_IDLE=$(( IDLE - PREV_IDLE ))
if (( DIFF_TOTAL == 0 )); then
    USAGE=0
else
    USAGE=$(( 100 * (DIFF_TOTAL - DIFF_IDLE) / DIFF_TOTAL ))
fi
(( USAGE < 0 )) && USAGE=0
(( USAGE > 100 )) && USAGE=100

# ---- append to rolling history (one line per run) ---------------------------
HISTFILE2="/tmp/waybar_cpu_hist2_$USER"
echo "$USAGE" >> "$HISTFILE2"
# keep only last $MAX entries
tail -n "$MAX" "$HISTFILE2" > "${HISTFILE2}.tmp" && mv "${HISTFILE2}.tmp" "$HISTFILE2"

# ---- append frequency to rolling history -------------------------------------
echo "$AVG_FREQ" >> "$HISTFILE_FREQ"
# keep only last $MAX entries
tail -n "$MAX" "$HISTFILE_FREQ" > "${HISTFILE_FREQ}.tmp" && mv "${HISTFILE_FREQ}.tmp" "$HISTFILE_FREQ"

# ---- build sparkline (8-level unicode blocks) -------------------------------
mapfile -t vals < "$HISTFILE2"
spark=""
for v in "${vals[@]}"; do
    # 0-100 → 0-7
    idx=$(( v * 7 / 100 ))
    case $idx in
        0) c="▁" ;; 1) c="▂" ;; 2) c="▃" ;; 3) c="▄" ;;
        4) c="▅" ;; 5) c="▆" ;; 6) c="▇" ;; *) c="█" ;;
    esac
    spark+="$c"
done

# ---- build frequency sparkline -----------------------------------------------
mapfile -t freq_vals < "$HISTFILE_FREQ"
freq_spark=""
for v in "${freq_vals[@]}"; do
    # Assume 800MHz-4000MHz → 0-7
    if (( v < 800 )); then idx=0; elif (( v > 4000 )); then idx=7; else idx=$(( (v - 800) * 7 / 3200 )); fi
    case $idx in
        0) c="▁" ;; 1) c="▂" ;; 2) c="▃" ;; 3) c="▄" ;;
        4) c="▅" ;; 5) c="▆" ;; 6) c="▇" ;; *) c="█" ;;
    esac
    freq_spark+="$c"
done

# ---- JSON output ------------------------------------------------------------
printf '{"text":"%s %s","tooltip":"CPU: %d%% | Freq: %d MHz"}\n' "$spark" "$freq_spark" "$USAGE" "$AVG_FREQ"

