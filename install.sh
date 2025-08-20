#!/bin/bash

set -e
set -o pipefail

GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

info() {
  echo -e "${GREEN}[INFO]${RESET} $1"
}
error() {
  echo -e "${RED}[ERROR]${RESET} $1"
}

info "Installing base packages..."
sudo pacman -Syu --noconfirm

info "Installing Xorg (display server)..."
sudo pacman -S --noconfirm xorg xorg-xinit


info "Checking if i3 is installed..."
if ! command -v i3 >/dev/null 2>&1; then
  info "Installing i3..."
  sudo pacman -S --noconfirm i3-wm
else
  info "i3 is already installed."
fi

info "Setting up .xinitrc to start i3..."
echo "exec i3" > "$HOME/.xinitrc"

if ! command -v yay >/dev/null 2>&1; then
  info "Installing yay (AUR helper)..."
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
  cd ~
else
  info "yay is already installed."
fi

info "Installing ghostty, polybar, rofi, picom, neovim, tmux, zsh..."
yay -S --noconfirm ghostty polybar rofi picom neovim tmux zsh xclip

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  info "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  info "oh-my-zsh already installed."
fi

DOTFILES_REPO="https://github.com/Aneeshie/arch-dotfiles.git"
CLONE_PATH="$HOME/.config"
BACKUP_PATH="$HOME/.config.backup.$(date +%s)"

if [ -d "$CLONE_PATH" ]; then
  info "Backing up existing .config to $BACKUP_PATH"
  mv "$CLONE_PATH" "$BACKUP_PATH"
fi

info "Cloning your repo into ~/.config..."
git clone "$DOTFILES_REPO" "$CLONE_PATH"

if [ -f "$HOME/.tmux.conf" ]; then
  TMUX_BACKUP="$HOME/.tmux.conf.backup.$(date +%s)"
  info "Backing up existing .tmux.conf to $TMUX_BACKUP"
  mv "$HOME/.tmux.conf" "$TMUX_BACKUP"
fi

if [ -f "$CLONE_PATH/.tmux.conf" ]; then
  info "Copying .tmux.conf to home directory"
  cp "$CLONE_PATH/.tmux.conf" "$HOME/.tmux.conf"

  info "Copying .tmux.conf to /root"
  sudo cp "$CLONE_PATH/.tmux.conf" /root/.tmux.conf
else
  error ".tmux.conf not found in $CLONE_PATH/"
fi

info "Done! Enjoyyyyy"
