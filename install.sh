#!/usr/bin/env bash

set -e

if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
curl -sS https://starship.rs/install.sh | sh

# Golang LS
go install golang.org/x/tools/gopls@latest

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
