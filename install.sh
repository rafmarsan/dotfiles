#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="install"
ASSUME_YES=0
PURGE=0

for arg in "$@"; do
    case "$arg" in
        --uninstall)
            MODE="uninstall"
            ;;
        --purge)
            PURGE=1
            ;;
        --yes|-y)
            ASSUME_YES=1
            ;;
        *)
            echo "Unknown option: $arg" >&2
            exit 1
            ;;
    esac
done

if [[ "$MODE" == "uninstall" ]]; then
    if [[ $ASSUME_YES -eq 0 ]]; then
        if [[ $PURGE -eq 1 ]]; then
            echo "This will remove dotfiles symlinks, extra packages, binaries and user data."
        else
            echo "This will remove only the symlinked dotfiles configuration."
        fi
        read -r -p "Continue? [y/N] " answer
        case "$answer" in
            [yY]|[yY][eE][sS]) ;;
            *) echo "Aborted."; exit 0 ;;
        esac
    fi

    if [[ $PURGE -eq 1 ]]; then
        if [[ "$(uname -s)" == "Darwin" ]]; then
            if [[ -x /opt/homebrew/bin/brew ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            elif [[ -x /usr/local/bin/brew ]]; then
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        fi

        case "$(uname -s)" in
            Darwin)
                "$SCRIPT_DIR/install/macos.sh" --uninstall
                ;;
            Linux)
                "$SCRIPT_DIR/install/linux.sh" --uninstall
                ;;
        esac

        rm -rf "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"
        rm -rf "$HOME/.local/share/uv" "$HOME/.local/state/uv" "$HOME/.cache/uv"
        rm -f "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"
        rm -f "$HOME/.local/bin/ansible" "$HOME/.local/bin/ansible-"*
        rm -rf "$HOME/.local/share/fonts/JetBrainsMono"
    fi

    "$SCRIPT_DIR/install/links.sh" --uninstall

    echo "Uninstall complete."
    exit 0
fi

case "$(uname -s)" in
    Darwin)
        if ! command -v brew >/dev/null 2>&1; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -x /usr/local/bin/brew ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi

        "$SCRIPT_DIR/install/macos.sh"
        ;;
    Linux)
        "$SCRIPT_DIR/install/linux.sh"
        ;;
esac

export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# Ansible
uv tool install --python 3.12 ansible-core==2.16.14

# Symlinks
echo "Deploying symlinks..."
"$SCRIPT_DIR/install/links.sh"

# Checks
"$SCRIPT_DIR/install/checks.sh"

echo
echo "Set zsh as default shell"
ZSH_PATH="$(command -v zsh)"

if ! grep -qx "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
    chsh -s "$ZSH_PATH"
fi
