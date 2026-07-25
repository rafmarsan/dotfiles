#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p ~/.config

ln -snf "$SCRIPT_DIR/nvim" ~/.config/nvim
ln -sf "$SCRIPT_DIR/zsh/.zshrc" ~/.zshrc
ln -sf "$SCRIPT_DIR/git/.gitconfig" ~/.gitconfig

ln -snf "$SCRIPT_DIR/alacritty" ~/.config/alacritty
ln -snf "$SCRIPT_DIR/tmux" ~/.config/tmux

