#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"

# Extract RAM values in Megabytes directly from /proc/meminfo to save execution time
TOTAL=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
AVAILABLE=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
USED=$((TOTAL - AVAILABLE))

# Calculate percentage
PERCENT=$((100 * USED / TOTAL))

# Convert used and total memory to clean human-readable gigabyte format (e.g., 9.4G/16G)
USED_GB=$(awk -v u="$USED" 'BEGIN {printf "%.1fG", u/1024/1024}')
TOTAL_GB=$(awk -v t="$TOTAL" 'BEGIN {printf "%.0fG", t/1024/1024}')

# Format Pango markup dynamically based on consumption thresholds
if [ "$PERCENT" -ge 90 ]; then
    TEXT="<span background=\"$RED\" foreground=\"$WHITE\"> mem $USED_GB/$TOTAL_GB </span>"
elif [ "$PERCENT" -ge 75 ]; then
    TEXT="<span background=\"$ORANGE\" foreground=\"$BLACK\"> mem $USED_GB/$TOTAL_GB </span>"
else
    TEXT="<span foreground=\"$GRAY\">mem $USED_GB/$TOTAL_GB</span>"
fi

echo "$TEXT"
echo "$USED_GB/$TOTAL_GB"
