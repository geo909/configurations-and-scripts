#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"

# Read disk usage for /
read -r USED_PCT AVAIL <<< "$(df -hP / | awk 'NR==2 {gsub(/%/,"",$5); print $5, $4}')"

UPCT=$((USED_PCT + 0))
TXT="/: $AVAIL free ($UPCT% used)  "

if [ "$UPCT" -ge 90 ]; then
    COLOR="$RED"
elif [ "$UPCT" -ge 75 ]; then
    COLOR="$ORANGE"
else
    COLOR="$GRAY"
fi

echo "<span foreground=\"$COLOR\">$TXT</span>"
echo "$TXT"
echo "$COLOR"
