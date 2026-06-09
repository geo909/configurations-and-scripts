#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"

# Isolate the Tctl value from your AMD sensor dump and drop the symbols
RAW_TEMP=$(sensors 2>/dev/null | awk '/Tctl:/ {print $2}' | tr -d '+°C')

# Fallback case just in case sensors changes names down the line
if [ -z "$RAW_TEMP" ]; then
    RAW_TEMP=$(sensors 2>/dev/null | awk '/temp1:/ {print $2; exit}' | tr -d '+°C')
fi

# Drop the decimal point to keep the bar text tiny and handle integer math in Bash
TEMP="${RAW_TEMP%.*}"

# Safety fallback if sensors fails to read entirely
if [ -z "$TEMP" ]; then
    echo "<span foreground=\"$GRAY\">--°C</span>"
    exit 0
fi

# Format Pango markup dynamically based on heat thresholds
if [ "$TEMP" -ge 97 ]; then
    # Critical: Red background block
    TEXT="<span background=\"$RED\" foreground=\"$WHITE\"> ${TEMP}°C </span>"
elif [ "$TEMP" -ge 90 ]; then
    # Warning: Orange background block
    TEXT="<span background=\"$ORANGE\" foreground=\"$BLACK\"> ${TEMP}°C </span>"
else
    # Quiet: Muted gray font string
    TEXT="<span foreground=\"$GRAY\">${TEMP}°C</span>"
fi

echo "$TEXT"
echo "${TEMP}°C"
