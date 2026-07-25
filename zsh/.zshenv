# Homebrew
for BREW in \
    /opt/homebrew/bin/brew \
    /home/linuxbrew/.linuxbrew/bin/brew
do
    if [[ -x "$BREW" ]]; then
        eval "$("$BREW" shellenv)"
        break
    fi
done

# uv
export PATH="$HOME/.local/bin:$PATH"

# go
export PATH="$HOME/go/bin:$PATH"
