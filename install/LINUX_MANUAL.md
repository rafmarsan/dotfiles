# Instalación manual en Linux

Equivalente paso a paso de `install.sh` + `install/linux.sh` + `install/links.sh`
para Debian/Ubuntu y Fedora. Ejecuta los bloques en orden. Los comandos con
`sudo` piden contraseña.

> Ejecuta todo desde la raíz del repositorio clonado.

## 0. Preparación

```bash
export DOTFILES="$PWD"
set -e
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
```

Comprueba tu distribución (elige luego **A** para Debian/Ubuntu o **B** para Fedora):

```bash
. /etc/os-release
echo "$ID / ${ID_LIKE:-}"
```

---

## A. Debian 13 / Ubuntu / Linux Mint / Pop!\_OS

### A.1 Paquetes base

```bash
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
```

### A.2 `fd` (en Debian el binario se llama `fdfind`)

```bash
sudo ln -sfn /usr/bin/fdfind /usr/local/bin/fd
```

### A.3 kubectl (repositorio oficial)

```bash
minor="$(curl -fsSL https://dl.k8s.io/release/stable.txt | cut -d. -f1-2)"
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL "https://pkgs.k8s.io/core:/stable:/${minor}/deb/Release.key" \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${minor}/deb/ /" \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list >/dev/null
sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

### A.4 glow (repositorio oficial de Charm)

```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key \
  | sudo gpg --dearmor --yes -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" \
  | sudo tee /etc/apt/sources.list.d/charm.list >/dev/null
sudo apt-get update
sudo apt-get install -y glow
```

### A.5 starship si está en los repos (opcional)

```bash
if apt-cache show starship >/dev/null 2>&1; then
  sudo apt-get install -y starship
fi
```

Si no lo está, el bloque **7** lo instala con el instalador oficial.

---

## B. Fedora

### B.1 Paquetes base

```bash
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
  tree-sitter-cli \
  unzip \
  fontconfig
```

### B.2 Node.js

```bash
if dnf info nodejs >/dev/null 2>&1; then
  sudo dnf install -y nodejs nodejs-npm
else
  sudo dnf install -y nodejs22 nodejs22-npm
fi
```

### B.3 kubectl (repositorio oficial)

```bash
minor="$(curl -fsSL https://dl.k8s.io/release/stable.txt | cut -d. -f1-2)"
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo >/dev/null
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/${minor}/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/${minor}/rpm/repodata/repomd.xml.key
EOF
sudo dnf install -y --allowerasing kubectl
```

### B.4 glow

```bash
if ! sudo dnf install -y glow; then
  echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo >/dev/null
  sudo dnf install -y glow
fi
```

---

## C. Pasos comunes (Debian y Fedora)

### 1. Neovim >= 0.12 (upstream si es necesario)

```bash
current="$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')"
if [ "$(printf '%s\n%s\n' "0.12.0" "$current" | sort -V | head -n1)" != "0.12.0" ]; then
  case "$(uname -m)" in
    x86_64|amd64) arch="x86_64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) echo "Arquitectura no soportada: $(uname -m)" >&2; exit 1 ;;
  esac
  tmp="$(mktemp -d)"
  curl -fL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" \
    -o "$tmp/nvim.tar.gz"
  sudo rm -rf /usr/local/nvim
  sudo mkdir -p /usr/local/nvim
  sudo tar -C /usr/local/nvim --strip-components=1 -xzf "$tmp/nvim.tar.gz"
  sudo ln -sfn /usr/local/nvim/bin/nvim /usr/local/bin/nvim
  rm -rf "$tmp"
fi
```

### 2. tree-sitter-cli >= 0.26.1 (upstream si es necesario)

```bash
current="$(tree-sitter --version | awk '{print $2}')"
if [ "$(printf '%s\n%s\n' "0.26.1" "$current" | sort -V | head -n1)" != "0.26.1" ]; then
  case "$(uname -m)" in
    x86_64|amd64) arch="x64" ;;
    aarch64|arm64) arch="arm64" ;;
    *) echo "Arquitectura no soportada: $(uname -m)" >&2; exit 1 ;;
  esac
  tmp="$(mktemp -d)"
  curl -fL "https://github.com/tree-sitter/tree-sitter/releases/latest/download/tree-sitter-cli-linux-${arch}.zip" \
    -o "$tmp/tree-sitter.zip"
  sudo unzip -o "$tmp/tree-sitter.zip" -d /usr/local/bin >/dev/null
  sudo chmod +x /usr/local/bin/tree-sitter
  rm -rf "$tmp"
fi
```

### 3. Fuente JetBrains Mono Nerd Font

```bash
tmp="$(mktemp -d)"
curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" \
  -o "$tmp/JetBrainsMono.zip"
sudo mkdir -p /usr/local/share/fonts/JetBrainsMono
sudo unzip -o "$tmp/JetBrainsMono.zip" -d /usr/local/share/fonts/JetBrainsMono >/dev/null
sudo fc-cache -f >/dev/null
rm -rf "$tmp"
```

### 4. starship

```bash
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh -s -- -y
fi
```

### 5. uv

```bash
if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi
export PATH="$HOME/.local/bin:$PATH"
```

### 6. Ansible (ansible-core vía uv)

```bash
uv tool install --python 3.12 ansible-core==2.16.14
```

### 7. Symlinks de configuración

```bash
mkdir -p ~/.config
ln -snf "$DOTFILES/nvim" ~/.config/nvim
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc
ln -sf "$DOTFILES/zsh/.zshenv" ~/.zshenv
ln -sf "$DOTFILES/zsh/.aliases.zsh" ~/.aliases.zsh
ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig
ln -snf "$DOTFILES/alacritty" ~/.config/alacritty
ln -snf "$DOTFILES/tmux" ~/.config/tmux
```

### 8. zsh como shell por defecto

```bash
ZSH_PATH="$(command -v zsh)"
if ! grep -qx "$ZSH_PATH" /etc/shells; then
  echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi
if [ "$SHELL" != "$ZSH_PATH" ]; then
  chsh -s "$ZSH_PATH"
fi
```

---

## D. Verificación

Comprueba que todo esté disponible:

```bash
for cmd in zsh git nvim tmux tree fd fzf rg watch entr glow starship go node npm uv ansible kubectl tree-sitter alacritty; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "OK   $cmd"
  else
    echo "FALTA $cmd"
  fi
done
```

Comprueba los symlinks:

```bash
for link in ~/.config/nvim ~/.config/alacritty ~/.config/tmux ~/.zshrc ~/.zshenv ~/.aliases.zsh ~/.gitconfig; do
  if [ -L "$link" ]; then
    echo "OK   $link -> $(readlink "$link")"
  else
    echo "FALTA $link"
  fi
done
```

## Notas

- `sudo` solo es necesario para paquetes y binarios en `/usr/local`.
- Los LSP se gestionan con Mason dentro de Neovim.
- Abre una nueva sesión de terminal (o ejecuta `exec zsh`) para cargar
  `starship`, `uv` y las rutas de `~/.local/bin`.
