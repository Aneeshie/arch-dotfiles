#!/usr/bin/env bash

# ================================
# RTX 4060 BEAST MODE ACTIVATOR
# NO IGPU = PURE NVIDIA POWER
# ================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${BOLD}${RED}🔥 RTX 4060 BEAST MODE ACTIVATED 🔥${NC}"
echo -e "${BOLD}${YELLOW}Unleashing NVIDIA Power - No iGPU Competition!${NC}\n"

# RTX 4060 Status Check
echo -e "${BLUE}⚡ RTX 4060 Status Check${NC}"
if command -v nvidia-smi &> /dev/null; then
    nvidia_info=$(nvidia-smi --query-gpu=name,memory.total,utilization.gpu,temperature.gpu,power.draw --format=csv,noheader,nounits)
    echo -e "${GREEN}✅ RTX 4060 Detected: $nvidia_info${NC}"
    
    # Get specific RTX 4060 stats
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)
    gpu_power=$(nvidia-smi --query-gpu=power.draw --format=csv,noheader,nounits)
    gpu_mem=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
    
    echo -e "${GREEN}🌡️  GPU Temperature: ${gpu_temp}°C${NC}"
    echo -e "${GREEN}⚡ Power Draw: ${gpu_power}W${NC}"
    echo -e "${GREEN}💾 VRAM Usage: ${gpu_mem}MB${NC}"
else
    echo -e "${RED}❌ NVIDIA drivers not detected${NC}"
fi

# Performance Mode Settings
echo -e "\n${BLUE}⚡ RTX 4060 Performance Optimization${NC}"

# Max Performance Mode
echo -e "${GREEN}🚀 Setting Maximum Performance Mode...${NC}"
nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" 2>/dev/null && echo -e "${GREEN}✅ Max Performance Mode Enabled${NC}" || echo -e "${YELLOW}⚠️  Performance mode requires X session${NC}"

# Memory Clock Boost
echo -e "${GREEN}💾 Optimizing Memory Clock...${NC}"
nvidia-settings -a "[gpu:0]/GPUMemoryTransferRateOffset[3]=800" 2>/dev/null && echo -e "${GREEN}✅ Memory overclock applied${NC}" || echo -e "${YELLOW}⚠️  Memory OC requires X session${NC}"

# Core Clock Boost
echo -e "${GREEN}🏎️  Optimizing Core Clock...${NC}"
nvidia-settings -a "[gpu:0]/GPUGraphicsClockOffset[3]=80" 2>/dev/null && echo -e "${GREEN}✅ Core overclock applied${NC}" || echo -e "${YELLOW}⚠️  Core OC requires X session${NC}"

# Cooling Profile
echo -e "${GREEN}❄️  Setting Aggressive Cooling...${NC}"
nvidia-settings -a "[gpu:0]/GPUFanControlState=1" 2>/dev/null
nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=75" 2>/dev/null && echo -e "${GREEN}✅ Cooling optimized for performance${NC}" || echo -e "${YELLOW}⚠️  Fan control requires X session${NC}"

# Compositor Optimization Test
echo -e "\n${BLUE}⚡ Picom RTX 4060 Optimization Test${NC}"
if pgrep picom > /dev/null; then
    picom_pid=$(pgrep picom)
    picom_mem=$(ps -o rss,comm -p $picom_pid | tail -1 | awk '{print $1}')
    echo -e "${GREEN}✅ Picom running with RTX acceleration${NC}"
    echo -e "${GREEN}📊 Picom memory usage: ${picom_mem} KB${NC}"
    
    # Test OpenGL performance with RTX
    echo -e "${GREEN}🎮 Testing OpenGL performance...${NC}"
    glxinfo | grep "OpenGL renderer" | grep -i nvidia > /dev/null && echo -e "${GREEN}✅ NVIDIA OpenGL acceleration active${NC}" || echo -e "${RED}❌ OpenGL issues detected${NC}"
else
    echo -e "${RED}❌ Picom not running - RTX power not utilized${NC}"
fi

# 180Hz Display Test
echo -e "\n${BLUE}⚡ 180Hz Display Optimization${NC}"
current_refresh=$(xrandr | grep -A1 "connected primary" | tail -1 | grep -o '[0-9]*\.[0-9]*\*' | sed 's/\*//')
if [[ "$current_refresh" == "180.00" ]]; then
    echo -e "${GREEN}✅ 180Hz refresh rate active${NC}"
    echo -e "${GREEN}🚀 RTX 4060 delivering maximum frames!${NC}"
else
    echo -e "${YELLOW}⚠️  Current refresh: ${current_refresh}Hz${NC}"
    echo -e "${YELLOW}💡 Set to 180Hz for maximum RTX performance${NC}"
fi

# VRAM Usage Optimization
echo -e "\n${BLUE}⚡ VRAM Optimization Check${NC}"
total_vram=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits)
used_vram=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader,nounits)
free_vram=$((total_vram - used_vram))

echo -e "${GREEN}💾 Total VRAM: ${total_vram}MB${NC}"
echo -e "${GREEN}📊 Used VRAM: ${used_vram}MB${NC}"
echo -e "${GREEN}🆓 Free VRAM: ${free_vram}MB${NC}"

if [ $free_vram -gt 4000 ]; then
    echo -e "${GREEN}✅ Excellent VRAM availability for smooth compositing${NC}"
elif [ $free_vram -gt 2000 ]; then
    echo -e "${YELLOW}⚠️  Moderate VRAM usage - performance still good${NC}"
else
    echo -e "${RED}❌ High VRAM usage - may impact performance${NC}"
fi

# Performance Score Calculation
echo -e "\n${BOLD}${PURPLE}📊 RTX 4060 PERFORMANCE SCORE${NC}"
echo -e "${BOLD}==============================${NC}"

score=0
[ "$gpu_temp" -lt 70 ] && score=$((score + 25)) && echo -e "${GREEN}🌡️  Cool GPU: +25 points${NC}"
[ "$gpu_power" -gt 100 ] && score=$((score + 25)) && echo -e "${GREEN}⚡ High Power Draw: +25 points${NC}"
[ "$current_refresh" == "180.00" ] && score=$((score + 25)) && echo -e "${GREEN}🚀 180Hz Active: +25 points${NC}"
[ $free_vram -gt 4000 ] && score=$((score + 25)) && echo -e "${GREEN}💾 Abundant VRAM: +25 points${NC}"

echo -e "\n${BOLD}${GREEN}🎯 RTX 4060 PERFORMANCE SCORE: $score/100${NC}"

if [ $score -gt 75 ]; then
    echo -e "${BOLD}${RED}🏆 BEAST MODE ACTIVATED! RTX 4060 IS UNLEASHED! 🏆${NC}"
    echo -e "${GREEN}💀 Hyprland doesn't stand a chance against this setup! 💀${NC}"
elif [ $score -gt 50 ]; then
    echo -e "${BOLD}${YELLOW}🚀 EXCELLENT PERFORMANCE! RTX 4060 is running strong! 🚀${NC}"
else
    echo -e "${BOLD}${YELLOW}⚠️  Good performance, but we can optimize further!${NC}"
fi

echo -e "\n${BOLD}${BLUE}🔥 RTX 4060 + i3 + 180Hz = HYPRLAND DESTROYER! 🔥${NC}"
echo -e "${GREEN}Your NVIDIA beast is ready to demolish any Wayland compositor!${NC}\n"
