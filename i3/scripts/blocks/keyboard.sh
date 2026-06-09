#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"

# Check the status of Group 2 from xset
GROUP_TWO_STATUS=$(xset -q | awk '/Group 2:/ {print $4}')

# Determine layout, background color, and text color for contrast
if [ "$GROUP_TWO_STATUS" = "on" ]; then
    LAYOUT="GR"
    BG_COLOR="$BLUE"
    FG_COLOR="$BLACK"
else
    LAYOUT="US"
    BG_COLOR="$MAGENTA"
    FG_COLOR="$WHITE"
fi

# Wrap the text in Pango markup with a background color and side padding spaces
TEXT="<span background=\"$BG_COLOR\" foreground=\"$FG_COLOR\"> $LAYOUT </span>"

# Output for i3blocks
echo "$TEXT"
echo "$LAYOUT"
