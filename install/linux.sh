#!/usr/bin/env bash

set -e

export PATH="$HOME/.local/bin:$PATH"

version_ge() {
    [ "$(printf '%s\n%s\n' "$2" "$1" | sort -V | head -n1)" = "$2" ]
}

install_glow_debian() {
    if command -v glow >/dev/null 2>&1; then
        return
    fi

    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key \
        | sudo gpg --dearmor --yes -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
        | sudo tee /etc/apt/sources.list.d/charm.list >/dev/null
    sudo apt-get update
    sudo apt-get install -y glow
}

install_glow_fedora() {
    if command -v glow >/dev/null 2>&1; then
        return
    fi

    if ! sudo dnf install -y glow; then
        echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo >/dev/null
        sudo dnf install -y glow
    fi
}

install_starship() {
    if command -v starship >/dev/null 2>&1; then
        return
    fi
    curl -sS https://starship.rs/install.sh | sh -s -- -y -b /usr/local/bin
}

install_uv() {
    if command -v uv >/dev/null 2>&1; then
        return
    fi
    curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
}

install_neovim_upstream() {
    local arch tmp
    case "$(uname -m)" in
        x86_64|amd64) arch="x86_64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
    esac

    tmp="$(mktemp -d)"
    curl -fL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" \
        -o "$tmp/nvim.tar.gz"
    sudo rm -rf /usr/local/nvim
    sudo mkdir -p /usr/local/nvim
    sudo tar -C /usr/local/nvim --strip-components=1 -xzf "$tmp/nvim.tar.gz"
    sudo ln -sfn /usr/local/nvim/bin/nvim /usr/local/bin/nvim
    rm -rf "$tmp"
}

install_kubectl_upstream() {
    local arch tmp version
    case "$(uname -m)" in
        x86_64|amd64) arch="amd64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
    esac

    tmp="$(mktemp -d)"
    version="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"
    curl -fL "https://dl.k8s.io/release/${version}/bin/linux/${arch}/kubectl" \
        -o "$tmp/kubectl"
    sudo install -m 0755 "$tmp/kubectl" /usr/local/bin/kubectl
    rm -rf "$tmp"
}

install_tree_sitter_cli_upstream() {
    local arch tmp
    case "$(uname -m)" in
        x86_64|amd64) arch="x64" ;;
        aarch64|arm64) arch="arm64" ;;
        *) echo "Unsupported architecture: $(uname -m)" >&2; exit 1 ;;
    esac

    tmp="$(mktemp -d)"
    curl -fL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-${arch}.zip" \
        -o "$tmp/tree-sitter.zip"
    sudo unzip -o "$tmp/tree-sitter.zip" -d /usr/local/bin >/dev/null
    sudo chmod +x /usr/local/bin/tree-sitter
    rm -rf "$tmp"
}

install_nerd_font() {
    if ls /usr/local/share/fonts/JetBrainsMono/*.ttf >/dev/null 2>&1 \
        || ls /usr/local/share/fonts/JetBrainsMono/*.otf >/dev/null 2>&1; then
        return
    fi

    local tmp
    tmp="$(mktemp -d)"
    curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" \
        -o "$tmp/JetBrainsMono.zip"
    sudo mkdir -p /usr/local/share/fonts/JetBrainsMono
    sudo unzip -o "$tmp/JetBrainsMono.zip" -d /usr/local/share/fonts/JetBrainsMono >/dev/null
    sudo fc-cache -f >/dev/null
    rm -rf "$tmp"
}

ensure_neovim() {
    local current
    current="$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')"
    if ! version_ge "$current" "0.12.0"; then
        echo "Neovim ${current} is too old, installing upstream..."
        install_neovim_upstream
    fi
}

ensure_tree_sitter() {
    local current
    current="$(tree-sitter --version | awk '{print $2}')"
    if ! version_ge "$current" "0.26.1"; then
        echo "tree-sitter ${current} is too old, installing upstream..."
        install_tree_sitter_cli_upstream
    fi
}

install_debian() {
    sudo apt-get update
    sudo apt-get install -y \
        build-essential \
        ca-certificates \
        curl \
        gpg \
        git \
        zsh \
        tmux \
        tree \
        fd-find \
        fzf \
        ripgrep \
        procps \
        entr \
        nodejs \
        npm \
        alacritty \
        golang-go \
        neovim \
        tree-sitter-cli \
        unzip \
        fontconfig

    sudo ln -sfn /usr/bin/fdfind /usr/local/bin/fd

    if apt-cache show kubectl >/dev/null 2>&1; then
        sudo apt-get install -y kubectl
    elif ! command -v kubectl >/dev/null 2>&1; then
        install_kubectl_upstream
    fi

    install_glow_debian

    if apt-cache show starship >/dev/null 2>&1; then
        sudo apt-get install -y starship
    fi
}

install_fedora() {
    sudo dnf install -y \
        gcc \
        gcc-c++ \
        make \
        ca-certificates \
        curl \
        git \
        zsh \
        tmux \
        tree \
        fd-find \
        fzf \
        ripgrep \
        procps-ng \
        entr \
        alacritty \
        neovim \
        golang \
        kubernetes1.36-client \
        tree-sitter-cli \
        unzip \
        fontconfig

    install_glow_fedora

    if dnf info nodejs >/dev/null 2>&1; then
        sudo dnf install -y nodejs nodejs-npm
    else
        sudo dnf install -y nodejs22 nodejs22-npm
    fi
}

uninstall_common_linux() {
    if command -v uv >/dev/null 2>&1; then
        uv tool uninstall ansible-core >/dev/null 2>&1 || true
    fi

    sudo rm -f /usr/local/bin/fd
    sudo rm -rf /usr/local/nvim
    sudo rm -f /usr/local/bin/nvim
    sudo rm -f /usr/local/bin/tree-sitter
    sudo rm -f /usr/local/bin/kubectl
    sudo rm -f /usr/local/bin/starship
    sudo rm -rf /usr/local/share/fonts/JetBrainsMono
    sudo fc-cache -f >/dev/null 2>&1 || true

    rm -rf "$HOME/.local/share/uv" "$HOME/.local/state/uv" "$HOME/.cache/uv"
    rm -f "$HOME/.local/bin/uv" "$HOME/.local/bin/uvx"
    rm -f "$HOME/.local/bin/ansible" "$HOME/.local/bin/ansible-"*
    rm -rf "$HOME/.local/share/fonts/JetBrainsMono"
}

uninstall_debian() {
    uninstall_common_linux

    sudo rm -f /etc/apt/keyrings/charm.gpg /etc/apt/sources.list.d/charm.list
    sudo apt-get remove -y \
        build-essential \
        tree \
        fd-find \
        fzf \
        ripgrep \
        entr \
        nodejs \
        npm \
        alacritty \
        golang-go \
        kubectl \
        neovim \
        tree-sitter-cli \
        starship \
        glow \
        2>/dev/null || true
    sudo apt-get autoremove -y >/dev/null 2>&1 || true
}

uninstall_fedora() {
    uninstall_common_linux

    sudo rm -f /etc/yum.repos.d/charm.repo
    sudo dnf remove -y \
        gcc \
        gcc-c++ \
        make \
        tree \
        fd-find \
        fzf \
        ripgrep \
        entr \
        alacritty \
        neovim \
        golang \
        kubernetes1.36-client \
        tree-sitter-cli \
        glow \
        starship \
        nodejs \
        nodejs-npm \
        nodejs22 \
        nodejs22-npm \
        2>/dev/null || true
    sudo dnf autoremove -y >/dev/null 2>&1 || true
}

. /etc/os-release

if [[ "${1:-}" == "--uninstall" ]]; then
    case "$ID" in
        debian|ubuntu|linuxmint|pop)
            uninstall_debian
            ;;
        fedora)
            uninstall_fedora
            ;;
        *)
            case "${ID_LIKE:-}" in
                *debian*) uninstall_debian ;;
                *fedora*|*rhel*) uninstall_fedora ;;
                *) echo "Unsupported distribution: $ID" >&2; exit 1 ;;
            esac
            ;;
    esac
    exit 0
fi

case "$ID" in
    debian|ubuntu|linuxmint|pop)
        install_debian
        ;;
    fedora)
        install_fedora
        ;;
    *)
        case "${ID_LIKE:-}" in
            *debian*) install_debian ;;
            *fedora*|*rhel*) install_fedora ;;
            *) echo "Unsupported distribution: $ID" >&2; exit 1 ;;
        esac
        ;;
esac

ensure_neovim
ensure_tree_sitter
install_starship
install_uv
install_nerd_font
