#!/usr/bin/env bash

source "$(dirname "$0")/../colors.sh"

# Fetch the raw acpi output
ACPI_OUT=$(acpi -b 2>/dev/null | head -n 1)

# Handle the case where no battery is found
if [ -z "$ACPI_OUT" ]; then
    echo "<span foreground=\"$GRAY\">No battery</span>"
    echo "No battery"
    exit 0
fi

# Parse out the status and percentage using native Bash regex
[[ "$ACPI_OUT" =~ Battery\ [0-9]+:\ ([^,]+) ]] && STATUS="${BASH_REMATCH[1]}"
[[ "$ACPI_OUT" =~ ([0-9]+)% ]] && PERCENT="${BASH_REMATCH[1]}"

# Trim any accidental whitespace
STATUS=$(echo "$STATUS" | xargs)

# Map the raw status to display labels with a threshold safeguard
case "$STATUS" in
    "Charging")
        LABEL="⚡ CHR"
        ;;
    "Full"|"Not charging")
        if [ "$PERCENT" -ge 98 ]; then
            LABEL="⚡ FULL"
        else
            LABEL="⚡ AC"  # Plugged in, but battery charge is capped/paused
        fi
        ;;
    *)
        LABEL="▮ BAT"
        ;;
esac

# Map percentages to a 5-tier color scheme
if [ "$PERCENT" -le 20 ]; then
    COLOR="$RED"; FG="$WHITE"      # Red (White text for contrast)
elif [ "$PERCENT" -le 40 ]; then
    COLOR="$ORANGE"; FG="$BLACK"   # Orange
elif [ "$PERCENT" -le 60 ]; then
    COLOR="$YELLOW"; FG="$BLACK"   # Yellow
elif [ "$PERCENT" -le 80 ]; then
    COLOR="$LIME"; FG="$BLACK"     # Greenish-Yellow
else
    COLOR="$GREEN_DARK"; FG="$WHITE"  # Green
fi

# Determine formatting based on whether we are plugged in or not
if [ "$STATUS" = "Charging" ] || [ "$STATUS" = "Full" ] || [ "$STATUS" = "Not charging" ]; then
    # Plugged in: Color applies to the FONT
    TEXT="<span foreground=\"$COLOR\">$LABEL $PERCENT%</span>"
else
    # Unplugged: Color applies to the BACKGROUND
    TEXT="<span background=\"$COLOR\" foreground=\"$FG\"> $LABEL $PERCENT% </span>"
fi

# Output for i3blocks
echo "$TEXT"
echo "$LABEL $PERCENT%"
