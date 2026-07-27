# Dotfiles

## Requirements

- Install [Alacritty](https://alacritty.org/)

## Installation

```bash
./install.sh
```

## Windows (WSL)

If you use **Alacritty for Windows** with WSL, the terminal configuration must live on the Windows side.

1. Install the Nerd Font:

```powershell
winget install DEVCOM.JetBrainsMonoNerdFont
```

2. Copy:

```text
%APPDATA%\alacritty\alacritty.toml
```

from:

```text
dotfiles/alacritty/alacritty.toml
```

## Included

- Neovim
- Tmux
- Zsh
- Alacritty
- Git
- Homebrew (macOS/Linux)
- LSPs
  - gopls
  - lua-language-server
  - basedpyright
  - ansible-language-server
