#!/bin/bash

# ==============================================================================
#  AESTHETIC DOTFILES INSTALLER
#  SAFE • ROBUST • STUNNING
# ==============================================================================

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Check for Arch Linux
if ! command -v pacman &> /dev/null; then
    error "This script requires Arch Linux."
    exit 1
fi

# Check for sudo
if ! sudo -n true 2>/dev/null; then
    error "Please ensure you have sudo privileges."
    exit 1
fi

# 1. Install Essentials
info "Installing essential packages..."
sudo pacman -S --needed --noconfirm \
    base-devel git wget curl unzip \
    xorg-server xorg-xinit xorg-xrandr \
    i3-wm polybar rofi picom dunst \
    feh maim flameshot xclip \
    ttf-jetbrains-mono-nerd \
    zsh neovim tmux \
    networkmanager network-manager-applet \
    pulseaudio pulseaudio-alsa pavucontrol \
    brightnessctl bluez bluez-utils blueman \
    firefox nautilus discord i3lock lxappearance \
    ranger htop lazygit copyq mesa-utils \
    nvidia-settings code

# 2. Install Yay (AUR Helper)
if ! command -v yay &> /dev/null; then
    info "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
else
    success "Yay is already installed."
fi

# 3. Install AUR Packages
info "Installing AUR packages (Ghostty, Zen Browser, Themes)..."
yay -S --needed --noconfirm \
    zen-browser-bin \
    ghostty \
    catppuccin-gtk-theme-mocha \
    papirus-icon-theme \
    sddm-catppuccin-git \
    rofi-calc \
    lazydocker \
    spotify

# 4. Install Configs (SAFELY)
info "Installing configurations..."
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

# List of configs to install
CONFIGS=("i3" "polybar" "rofi" "picom" "dunst" "ghostty")

for cfg in "${CONFIGS[@]}"; do
    if [ -d "$cfg" ]; then
        TARGET="$CONFIG_DIR/$cfg"
        if [ -d "$TARGET" ]; then
            BACKUP="$TARGET.backup.$(date +%s)"
            warn "Backing up existing $cfg to $BACKUP"
            mv "$TARGET" "$BACKUP"
        fi
        info "Installing $cfg config..."
        cp -r "$cfg" "$CONFIG_DIR/"
    else
        warn "Config directory '$cfg' not found in current folder, skipping."
    fi
done

# 5. Scripts
info "Installing scripts..."
mkdir -p "$HOME/.local/bin"
if [ -d "scripts" ]; then
    cp -r scripts/* "$HOME/.local/bin/"
    chmod +x "$HOME/.local/bin/"*
fi

# 6. Wallpaper
if [ ! -f "$CONFIG_DIR/catppuccin-wallpaper.png" ]; then
    info "Downloading wallpaper..."
    wget -q "https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/shaded_landscape.png" -O "$CONFIG_DIR/catppuccin-wallpaper.png"
fi

# 7. Shell Setup (Oh My Zsh)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

success "Installation Complete! Please reboot your system."
