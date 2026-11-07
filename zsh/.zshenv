# Homebrew (macOS)
if [[ "$(uname -s)" == "Darwin" ]]; then
    for BREW in \
        /opt/homebrew/bin/brew \
        /usr/local/bin/brew
    do
        if [[ -x "$BREW" ]]; then
            eval "$("$BREW" shellenv)"
            break
        fi
    done
fi

# uv and Python tools
export PATH="$HOME/.local/bin:$PATH"

# Go
export PATH="$HOME/go/bin:$PATH"
