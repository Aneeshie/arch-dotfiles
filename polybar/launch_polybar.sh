#!/usr/bin/env bash

# Launch Polybar on all connected monitors using the "main" bar from config.ini
if type "xrandr" >/dev/null 2>&1; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR="$m" polybar --reload main &
  done
else
  polybar --reload main &
fi
