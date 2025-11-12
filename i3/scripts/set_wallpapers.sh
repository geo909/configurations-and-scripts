#!/usr/bin/env bash
# Set the same random wallpaper on all monitors using feh (no stretching).

WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Get a random image (jpg/png) from the directory
IMG="$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n 1)"

# Exit if none found
[ -z "$IMG" ] && exit 1

echo "Setting wallpaper: $IMG"
# --bg-fill fills the screen, preserving aspect ratio (may crop).
# Use --bg-max instead if you prefer no cropping (may letterbox).
feh --no-fehbg --bg-fill "$IMG"
