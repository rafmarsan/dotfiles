#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

LINKS=(
    "$HOME/.config/nvim"
    "$HOME/.config/alacritty"
    "$HOME/.config/tmux"
    "$HOME/.zshrc"
    "$HOME/.zshenv"
    "$HOME/.aliases.zsh"
    "$HOME/.gitconfig"
)

if [[ "${1:-}" == "--uninstall" ]]; then
    for link in "${LINKS[@]}"; do
        if [[ -L "$link" ]]; then
            target="$(readlink "$link")"
            case "$target" in
                "$SCRIPT_DIR"/*) rm -f "$link" ;;
            esac
        fi
    done
    exit 0
fi

mkdir -p ~/.config

ln -snf "$SCRIPT_DIR/nvim" ~/.config/nvim
ln -sf "$SCRIPT_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$SCRIPT_DIR/zsh/.zshenv" ~/.zshenv
ln -sf "$SCRIPT_DIR/zsh/.aliases.zsh" ~/.aliases.zsh

ln -sf "$SCRIPT_DIR/git/.gitconfig" ~/.gitconfig

ln -snf "$SCRIPT_DIR/alacritty" ~/.config/alacritty
ln -snf "$SCRIPT_DIR/tmux" ~/.config/tmux
