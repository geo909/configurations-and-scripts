#!/bin/sh
# 1) Try "raise pin under mouse"
eval "$(xdotool getmouselocation --shell)" || exit 0
if [ -n "$WINDOW" ] && [ "$(xdotool getwindowclassname "$WINDOW" 2>/dev/null)" = "flameshot" ]; then
  xdotool windowraise "$WINDOW"
  exit 0
fi
# 2) Fallback: let user click a window to raise
id="$(xdotool selectwindow 2>/dev/null)" || exit 0
[ -n "$id" ] || exit 0
[ "$(xdotool getwindowclassname "$id" 2>/dev/null)" = "flameshot" ] && xdotool windowraise "$id"
