# .zshrc

source ~/.aliases.zsh

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

WORDCHARS=${WORDCHARS//\/}

bindkey "^[b" backward-word
bindkey "^[f" forward-word

eval "$(starship init zsh)"
