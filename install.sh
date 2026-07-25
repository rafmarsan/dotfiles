#!/usr/bin/env bash

set -e

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

case "$(uname -s)" in
    Darwin)
        ./install/macos.sh
        ;;
    Linux)
        ./install/linux.sh
        ;;
esac

# Startship
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh
fi

# Golang LS
go install golang.org/x/tools/gopls@latest
export PATH="$HOME/go/bin:$PATH"

# Ansible and Python LS
uv tool install ansible-core==2.16.14
uv tool install basedpyright

# Ansible LS
npm install -g @ansible/ansible-language-server

# Symlinks
echo "Deploying symlinks..."
./install/links.sh

# Checks
./install/checks.sh

echo
echo "Set zsh as default shell"
ZSH_PATH="$(which zsh)"

if ! grep -qx "$ZSH_PATH" /etc/shells; then
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
    chsh -s "$ZSH_PATH"
fi
