#  Arch Dotfiles Setup

> Personal Arch Linux dotfiles setup script -->> includes a full power-user experience with i3, Ghostty, Polybar, Tmux, Zsh (oh-my-zsh), and more.

---

## 💡 Features

- Minimal, aesthetic i3 window manager
-  Compositor with `picom` for transparency & shadows
-  `tmux` config with ALT+SHIFT keybindings (Ghostty-friendly)
-  ZSH powered by `oh-my-zsh`
- terminal: `ghostty` as default
-  AUR support via `yay`
-  Custom dotfiles pulled directly into `~/.config`
-  Auto backup of any existing config before overwrite

---

## ⚙️ What It Installs

| Tool        | Description                            |
|-------------|----------------------------------------|
| `i3-wm`     | Window manager                         |
| `ghostty`   | GPU-accelerated terminal               |
| `polybar`   | Status bar                             |
| `rofi`      | Application launcher                   |
| `picom`     | Compositor for effects (blur/shadow)  |
| `neovim`    | Modern Vim-based text editor           |
| `tmux`      | Terminal multiplexer                   |
| `zsh`       | Shell of legends                       |
| `oh-my-zsh` | Zsh plugin/theme framework             |

---

##  How to Use

> Make sure you're running this on **Arch Linux** or an Arch-based distro!

### Step 1: Clone the Repo

```bash
git clone https://github.com/yourusername/arch-dotfiles.git
cd arch-dotfiles
```

### Step 2: run install.sh
```bash
chmod +x ./install.sh
./install.sh
```
