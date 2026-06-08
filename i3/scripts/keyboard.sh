#!/usr/bin/env bash

# Check the status of Group 2 from xset
GROUP_TWO_STATUS=$(xset -q | awk '/Group 2:/ {print $4}')

# Determine layout, background color, and text color for contrast
if [ "$GROUP_TWO_STATUS" = "on" ]; then
    LAYOUT="GR"
    BG_COLOR="#4da3ff"  # Original light blue
    FG_COLOR="#000000"  # Black text for crisp contrast
else
    LAYOUT="US"
    BG_COLOR="#eb34d8"  # Original magenta/pink
    FG_COLOR="#ffffff"  # White text for crisp contrast
fi

# Wrap the text in Pango markup with a background color and side padding spaces
TEXT="<span background=\"$BG_COLOR\" foreground=\"$FG_COLOR\"> $LAYOUT </span>"

# Output for i3blocks
echo "$TEXT"
echo "$LAYOUT"
