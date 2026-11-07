# Dotfiles

## Requirements

- Install [Alacritty](https://alacritty.org/) (installed automatically on Linux)

## Supported systems

- macOS (Homebrew)
- Debian 13 / Ubuntu (apt)
- Fedora 44 / 45 (dnf)

## Installation

```bash
./install.sh
```

The installer is idempotent: running it again updates what is missing and skips
what is already installed.

On Linux, `sudo` is required for packages and system-wide binaries.

## Uninstall

By default, only the configuration files deployed as symlinks are removed.
Installed binaries and packages are kept so the system stays consistent:

```bash
./uninstall.sh
```

If you also want to remove the packages, upstream binaries, fonts and user
data created by the setup:

```bash
./uninstall.sh --purge
```

Use `--yes` to skip the confirmation prompt:

```bash
./uninstall.sh --purge --yes
```

Core tools such as `git`, `zsh` and `tmux` are always kept, even with
`--purge`. Homebrew itself is kept on macOS.

## Linux notes

- Homebrew is **not** used on Linux.
- Packages are installed with `apt` or `dnf`.
- Neovim and tree-sitter-cli are installed natively when the distribution
  version is recent enough. On Debian 13 the native versions do not meet the
  requirements, so the official upstream releases are installed under
  `/usr/local`.
- `glow` is installed from the official Charm repository on Debian.
- `starship` is installed from the official installer on Fedora.
- `uv` is installed with its official installer and is used for Python
  projects and `ansible-core`.
- LSPs are managed by Mason inside Neovim.
- The JetBrains Mono Nerd Font is installed system-wide under
  `/usr/local/share/fonts`.

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
- Homebrew (macOS only)
- LSPs (Mason)
  - gopls
  - lua-language-server
  - basedpyright
  - ansible-language-server
