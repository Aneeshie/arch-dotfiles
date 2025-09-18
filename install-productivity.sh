#!/bin/bash

# =====================================
# PRODUCTIVITY-FOCUSED DOTFILES INSTALLER
# Catppuccin Theme | 2560x1440@180hz Optimized
# =====================================

set -e  # Exit on error

echo "🚀 Installing productivity-focused dotfiles..."

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}[STEP]${NC} $1"
}

# Check if running on Arch Linux
if ! command -v pacman &> /dev/null; then
    print_error "This script is designed for Arch Linux systems"
    exit 1
fi

print_header "Installing core system packages..."
sudo pacman -S --needed --noconfirm \
  i3-wm \
  polybar \
  rofi \
  picom \
  feh \
  maim \
  flameshot \
  xdotool \
  xsel \
  xclip \
  ttf-meslo-nerd \
  firefox \
  ghostty || print_warning "Some packages may not be available in official repos"

print_header "Installing productivity tools..."
sudo pacman -S --needed --noconfirm \
  ranger \
  lf \
  htop \
  iotop \
  iftop \
  copyq \
  dunst \
  redshift \
  brightnessctl \
  blueman \
  nautilus \
  code \
  neovim \
  tmux \
  zsh \
  git \
  curl \
  wget \
  unzip \
  zip \
  tree \
  fd \
  ripgrep \
  bat \
  exa \
  diff-so-fancy || print_warning "Some productivity tools may not be available"

# Install AUR packages if yay is available
if command -v yay &> /dev/null; then
    print_header "Installing AUR packages..."
    yay -S --needed --noconfirm \
        zen-browser-bin \
        lazydocker \
        lazygit \
        catppuccin-gtk-theme-mocha \
        papirus-icon-theme \
        rofi-calc || print_warning "Some AUR packages failed to install"
else
    print_warning "yay not found. Please install AUR packages manually:"
    echo "  - zen-browser-bin"
    echo "  - lazydocker" 
    echo "  - lazygit"
    echo "  - catppuccin-gtk-theme-mocha"
    echo "  - papirus-icon-theme"
    echo "  - rofi-calc"
fi

print_header "Creating configuration directories..."
mkdir -p ~/.config/{i3,polybar,rofi,picom,ranger,dunst,redshift,copyq}
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/.local/bin

# Backup existing configs
print_header "Backing up existing configurations..."
for config in i3 polybar rofi picom ranger; do
    if [ -d ~/.config/$config ]; then
        backup_name=~/.config/$config.backup.$(date +%Y%m%d_%H%M%S)
        mv ~/.config/$config $backup_name
        print_warning "Backed up existing $config config to $backup_name"
    fi
done

print_header "Installing HYPRLAND-DESTROYING configuration files..."

# Main configs (SPEED OPTIMIZED)
cp -r i3 ~/.config/
cp -r polybar ~/.config/
cp -r rofi ~/.config/
cp -r picom ~/.config/
cp -r ranger ~/.config/
cp -r scripts ~/.config/

# Make all scripts executable for maximum speed
chmod +x ~/.config/scripts/*.sh

# Terminal configs
if [ -d "ghostty" ]; then
    mkdir -p ~/.config/ghostty
    cp -r ghostty/* ~/.config/ghostty/
fi

# Tmux
cp .tmux.conf ~/

print_header "Setting up wallpaper..."
# Download Catppuccin wallpaper if not exists
if [ ! -f "catppuccin-wallpaper.png" ]; then
    print_status "Downloading Catppuccin wallpaper..."
    wget -q "https://raw.githubusercontent.com/catppuccin/wallpapers/main/landscapes/shaded_landscape.png" -O catppuccin-wallpaper.png || print_warning "Failed to download wallpaper"
fi

# Copy wallpaper
cp catppuccin-wallpaper.png ~/.config/ 2>/dev/null || \
cp gruvbox-wallpaper.png ~/.config/catppuccin-wallpaper.png 2>/dev/null || \
print_warning "No wallpaper found"

print_header "Making scripts executable..."
find ~/.config -name "*.sh" -type f -exec chmod +x {} \;

print_header "Installing productivity scripts..."
if [ -f "rofi/productivity.sh" ]; then
    cp rofi/productivity.sh ~/.local/bin/
    chmod +x ~/.local/bin/productivity.sh
fi

if [ -f "rofi/powermenu.sh" ]; then
    cp rofi/powermenu.sh ~/.local/bin/
    chmod +x ~/.local/bin/powermenu.sh
fi

print_header "Configuring system settings..."

# Add ~/.local/bin to PATH
if ! grep -q "~/.local/bin" ~/.bashrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

if ! grep -q "~/.local/bin" ~/.zshrc 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
fi

# Set zsh as default shell
if command -v zsh &> /dev/null && [ "$SHELL" != "/usr/bin/zsh" ]; then
    print_status "Setting zsh as default shell..."
    chsh -s /usr/bin/zsh || print_warning "Failed to change shell to zsh"
fi

# Configure git if not already configured
if ! git config --global user.name &> /dev/null; then
    print_status "Git not configured. Please run:"
    echo "  git config --global user.name 'Your Name'"
    echo "  git config --global user.email 'your.email@example.com'"
fi

print_header "Creating desktop entry for i3..."
cat > ~/.config/autostart/productivity-setup.desktop << EOF
[Desktop Entry]
Type=Application
Name=Productivity Setup
Exec=true
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Comment=Productivity setup completion marker
EOF

# Print completion message with full feature list
clear
echo ""
echo "======================================"
echo "   🚀 PRODUCTIVITY SETUP COMPLETE! 🚀"
echo "======================================"
echo ""
echo "🎯 Features Installed:"
echo "   • Catppuccin Mocha theme (no more Gruvbox!)"
echo "   • Zen Browser as default (optimized for productivity)"
echo "   • LazyDocker for container management"
echo "   • Advanced file managers: Ranger & LF"
echo "   • System monitoring: htop, iotop, iftop"
echo "   • Clipboard manager with history (CopyQ)"
echo "   • RTX 4060 NUCLEAR OPTIMIZATIONS (no iGPU competition!)"
echo "   • Performance-optimized for 2560x1440@180Hz"
echo "   • Bottom polybar with comprehensive system stats"
echo "   • Smart workspace organization"
echo "   • Advanced rofi menus"
echo "   • NVIDIA GPU acceleration with picom"
echo "   • Automatic RTX overclocking and performance modes"
echo ""
echo "⌨️  Essential Keybinds:"
echo "   Super+D         - Application launcher"
echo "   Super+Space     - Combined launcher"  
echo "   Super+Tab       - Window switcher"
echo "   Super+B         - Zen browser"
echo "   Super+N         - Ranger file manager"
echo "   Super+Shift+N   - Nautilus GUI file manager"
echo "   Super+V         - Clipboard manager"
echo "   Super+C         - Calculator"
echo ""
echo "🔧 Advanced Tools:"
echo "   Super+Ctrl+D    - LazyDocker"
echo "   Super+Ctrl+G    - LazyGit"
echo "   Super+Ctrl+H    - System monitor (htop)"
echo "   Super+Ctrl+I    - I/O monitor (iotop)"
echo "   Super+Ctrl+O    - Productivity menu"
echo "   Super+Ctrl+P    - Power menu"
echo ""
echo "🔥 RTX 4060 BEAST MODE:"
echo "   Super+Ctrl+Shift+R - RTX 4060 Beast Mode Activation"
echo "   Super+Ctrl+Shift+B - Hyprland Killer Benchmark"
echo "   (Automatic GPU overclocking and performance tuning)"
echo ""
echo "🚀 Productivity Features:"
echo "   • Smart window management with gaps"
echo "   • Auto-workspace assignment"
echo "   • Performance monitoring in polybar"
echo "   • Quick screenshot tools"
echo "   • Advanced clipboard with history"
echo "   • Blue light filter (Redshift)"
echo "   • Notification system (Dunst)"
echo ""
echo "🎨 Visual Improvements:"
echo "   • Modern Catppuccin color scheme"
echo "   • Minimal bottom polybar (20pt height)"
echo "   • Smooth animations optimized for 180Hz"
echo "   • Consistent theming across all applications"
echo ""
echo "📚 Next Steps:"
echo "   1. Log out and select i3 from your display manager"
echo "   2. Your display will be set to 2560x1440@180Hz automatically"
echo "   3. Explore the productivity menu: Super+Ctrl+O"
echo "   4. Set up your Git credentials if needed"
echo "   5. Install additional tools as needed"
echo ""
print_status "YOUR PRODUCTIVITY SHOULD NOW BE TRIPLED! 🚀"
echo ""
echo "💡 Pro tip: Use Super+? to see more keybinds in i3"
echo "🔗 Need help? Check the configs in ~/.config/"
echo ""
echo "Enjoy your supercharged productivity setup! ⚡"
