#!/usr/bin/env bash

# Rofi Power Menu with Catppuccin Theme
# Keyboard-accessible system controls

theme="~/.config/rofi/catppuccin-mocha.rasi"

# Options with icons
lock="  Lock"
logout="  Logout"
suspend="  Suspend"
reboot="  Reboot"
shutdown="  Shutdown"

# Show menu
selected=$(echo -e "$lock\n$logout\n$suspend\n$reboot\n$shutdown" | rofi -dmenu -p "Power Menu" -theme $theme)

case $selected in
    $lock)
        i3lock -c 1e1e2e
        ;;
    $logout)
        i3-msg exit
        ;;
    $suspend)
        systemctl suspend
        ;;
    $reboot)
        systemctl reboot
        ;;
    $shutdown)
        systemctl poweroff
        ;;
esac
