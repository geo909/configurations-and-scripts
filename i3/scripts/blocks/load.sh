#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"

# Read the 1, 5, and 15 minute load averages from /proc/loadavg
read -r LOAD_1 LOAD_5 LOAD_15 _ < /proc/loadavg

# Determine the urgency status using awk
STATUS=$(awk -v val="$LOAD_1" 'BEGIN {
    if (val >= 4.0)      print "CRIT"
    else if (val >= 2.5) print "WARN"
    else                 print "NORMAL"
}')

# Format the Pango markup dynamically based on urgency
if [ "$STATUS" = "CRIT" ]; then
    TEXT="<span background=\"$RED\" foreground=\"$WHITE\"> load $LOAD_1  $LOAD_5  $LOAD_15 </span>"
elif [ "$STATUS" = "WARN" ]; then
    TEXT="<span background=\"$ORANGE\" foreground=\"$BLACK\"> load $LOAD_1  $LOAD_5  $LOAD_15 </span>"
else
    TEXT="<span foreground=\"$GRAY\">load $LOAD_1  $LOAD_5  $LOAD_15</span>"
fi

# Output for i3blocks
echo "$TEXT"
echo "load $LOAD_1"
