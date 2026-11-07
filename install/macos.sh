#!/usr/bin/env bash

set -e

FORMULAS=(
    git
    neovim
    tmux
    tree
    fd
    fzf
    ripgrep
    watch
    entr
    glow
    starship
    go
    node
    uv
    kubernetes-cli
    tree-sitter
    tree-sitter-cli
)

CASK="font-jetbrains-mono-nerd-font"

if [[ "${1:-}" == "--uninstall" ]]; then
    if command -v uv >/dev/null 2>&1; then
        uv tool uninstall ansible-core >/dev/null 2>&1 || true
    fi

    if command -v brew >/dev/null 2>&1; then
        for formula in "${FORMULAS[@]}"; do
            if brew list --formula "$formula" >/dev/null 2>&1; then
                brew uninstall "$formula" || true
            fi
        done

        if brew list --cask "$CASK" >/dev/null 2>&1; then
            brew uninstall --cask "$CASK" || true
        fi
    fi

    rm -rf "$HOME/.local/share/uv" "$HOME/.local/state/uv" "$HOME/.cache/uv"
    rm -f "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"
    rm -f "$HOME/.local/bin/ansible" "$HOME/.local/bin/ansible-"*
    rm -rf "$HOME/.local/share/fonts/JetBrainsMono"
    exit 0
fi

brew update
brew install "${FORMULAS[@]}"
brew install --cask "$CASK"
