#!/usr/bin/env bash

# Rofi Productivity Menu
# Quick access to development and productivity tools

theme="~/.config/rofi/catppuccin-mocha.rasi"

# Productivity tools with icons
file_manager="  File Manager"
lazy_docker="  Lazy Docker"
system_monitor="  System Monitor"
network_monitor="  Network Monitor"
process_monitor="  Process Monitor"
clipboard_manager="  Clipboard History"
calculator="  Calculator"
code_editor="  Code Editor"
git_client="  Git Client"
terminal="  Terminal"

# Show menu
selected=$(echo -e "$file_manager\n$lazy_docker\n$system_monitor\n$network_monitor\n$process_monitor\n$clipboard_manager\n$calculator\n$code_editor\n$git_client\n$terminal" | rofi -dmenu -p "Productivity Tools" -theme $theme)

case $selected in
    "$file_manager")
        ghostty -e ranger
        ;;
    "$lazy_docker")
        ghostty --class="lazydocker" -e lazydocker
        ;;
    "$system_monitor")
        ghostty --class="htop" -e htop
        ;;
    "$network_monitor")
        ghostty --class="iftop" -e sudo iftop
        ;;
    "$process_monitor")
        ghostty --class="iotop" -e sudo iotop
        ;;
    "$clipboard_manager")
        copyq toggle
        ;;
    "$calculator")
        rofi -show calc -theme $theme
        ;;
    "$code_editor")
        code .
        ;;
    "$git_client")
        ghostty --class="lazygit" -e lazygit
        ;;
    "$terminal")
        ghostty
        ;;
esac
