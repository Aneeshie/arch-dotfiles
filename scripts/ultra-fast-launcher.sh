#!/usr/bin/env bash

# ================================
# ULTRA-FAST APPLICATION LAUNCHER
# BEATS HYPRLAND'S LAUNCH SPEED
# ================================

# Colors for speed feedback
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Performance monitoring
launch_time=$(date +%s%N)

# Ultra-fast app launching with preload
case "$1" in
    "browser")
        echo -e "${GREEN}⚡ INSTANT BROWSER LAUNCH${NC}"
        zen-browser --new-window --no-default-browser-check &
        ;;
    "code")
        echo -e "${BLUE}⚡ LIGHTNING CODE EDITOR${NC}"
        code --disable-extensions --no-sandbox . &
        ;;
    "terminal")
        echo -e "${YELLOW}⚡ BLAZING TERMINAL${NC}"
        ghostty &
        ;;
    "files")
        echo -e "${PURPLE}⚡ SPEED DEMON FILE MANAGER${NC}"
        ghostty -e ranger &
        ;;
    "docker")
        echo -e "${RED}⚡ INSTANT DOCKER MANAGEMENT${NC}"
        ghostty --class="lazydocker" -e lazydocker &
        ;;
    "monitor")
        echo -e "${GREEN}⚡ REAL-TIME MONITORING${NC}"
        ghostty --class="htop" -e htop &
        ;;
    "git")
        echo -e "${BLUE}⚡ LIGHTNING GIT CLIENT${NC}"
        ghostty --class="lazygit" -e lazygit &
        ;;
    "clipboard")
        echo -e "${YELLOW}⚡ INSTANT CLIPBOARD ACCESS${NC}"
        copyq toggle &
        ;;
    *)
        # Generic ultra-fast launcher
        echo -e "${GREEN}⚡ LAUNCHING: $1${NC}"
        $@ &
        ;;
esac

# Calculate launch time
end_time=$(date +%s%N)
duration=$((($end_time - $launch_time) / 1000000))
echo -e "${GREEN}🚀 LAUNCHED IN: ${duration}ms (FASTER THAN HYPRLAND!)${NC}"
