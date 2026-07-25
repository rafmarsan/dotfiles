#!/usr/bin/env bash

set -e

brew install \
    git \
    neovim \
    tmux \
    tree \
    fd \
    fzf \
    ripgrep \
    watch \
    entr \
    glow \
    go \
    node \
    uv \
    lua-language-server \
    kubernetes-cli \
    tree-sitter \
    tree-sitter-cli

brew install --cask \
    font-jetbrains-mono-nerd-font
