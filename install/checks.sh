#!/usr/bin/env bash

FAILED=0

GREEN="\033[0;32m"
RED="\033[0;31m"
BLUE="\033[0;34m"
RESET="\033[0m"

check_cmd() {
    if command -v "$1" >/dev/null 2>&1; then
        printf "${GREEN}✓${RESET} %-30s\n" "$1"
    else
        printf "${RED}✗${RESET} %-30s\n" "$1"
        FAILED=1
    fi
}

check_link() {
    if [[ -L "$1" ]]; then
        printf "${GREEN}✓${RESET} %-30s\n" "$1"
    else
        printf "${RED}✗${RESET} %-30s\n" "$1"
        FAILED=1
    fi
}

echo
printf "${BLUE}== Commands ==${RESET}\n\n"

check_cmd brew
check_cmd git
check_cmd nvim
check_cmd tmux
check_cmd tree
check_cmd fd
check_cmd fzf
check_cmd rg
check_cmd watch
check_cmd entr
check_cmd glow

check_cmd go
check_cmd gopls

check_cmd node
check_cmd npm

check_cmd uv
check_cmd basedpyright

check_cmd ansible
check_cmd ansible-playbook
check_cmd ansible-galaxy

check_cmd ansible-language-server
check_cmd lua-language-server
check_cmd kubectl
check_cmd tree-sitter


echo
printf "${BLUE}== Symlinks ==${RESET}\n\n"

check_link ~/.config/nvim
check_link ~/.config/alacritty
check_link ~/.config/tmux
check_link ~/.zshrc
check_link ~/.aliases.zsh
check_link ~/.gitconfig

echo

if [[ $FAILED -eq 0 ]]; then
    printf "${GREEN}✔ All checks passed.${RESET}\n"
else
    printf "${RED}✘ Some checks failed.${RESET}\n"
    exit 1
fi
